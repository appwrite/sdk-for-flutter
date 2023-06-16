import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../call_params.dart';
import '../client_mixin.dart';
import '../client_offline_mixin.dart';
import '../enums.dart';
import '../exception.dart';
import '../offline/caller.dart';
import '../offline/route.dart';
import '../offline/route_mapping.dart';
import '../offline/router.dart';
import '../response.dart';
import 'call_handler.dart';
import 'http_call_handler.dart';

const offlinePersistencyKey = 'offlinePersistency';

bool getOfflinePersistency(CallParams params) {
  final offlinePersistency = params.context[offlinePersistencyKey];
  if (offlinePersistency == null) return false;
  return offlinePersistency as bool;
}

CallParams withOfflinePersistency(CallParams params, bool status) {
  params.context[offlinePersistencyKey] = status;
  return params;
}

class CacheParams {
  final String model;
  final String key;
  final String responseIdKey;
  final String responseContainerKey;
  final Map<String, Object?>? previous;

  CacheParams({
    this.model = '',
    this.key = '',
    this.responseIdKey = '',
    this.responseContainerKey = '',
    this.previous,
  });
}

const cacheParamsKey = 'cacheParams';

CacheParams getCacheParams(CallParams params) {
  final cacheParams = params.context[cacheParamsKey];
  if (cacheParams == null) return CacheParams();
  return cacheParams as CacheParams;
}

CallParams withCacheParams(CallParams params, CacheParams cacheParams) {
  params.context[cacheParamsKey] = cacheParams;
  return params;
}

class OfflineCallHandler extends CallHandler
    with ClientMixin, ClientOfflineMixin {
  final Caller _call;
  final Router _router = Router();

  OfflineCallHandler(this._call) {
    routes.forEach((route) {
      final method = (route['method'] as String).toUpperCase();
      final path = route['path'] as String;
      final offline = route['offline'] as Map<String, String>;
      _router.addRoute(
        Route(method, path)
            .label('offline.model', offline['model']!)
            .label('offline.key', offline['key']!)
            .label('offline.response-key', offline['response-key']!)
            .label('offline.container-key', offline['container-key']!),
      );
    });
  }

  @override
  Future<Response> handleCall(CallParams params) async {
    final endpoint = getEndpoint(params);
    final offlinePersistency = getOfflinePersistency(params);

    if (offlinePersistency) {
      params.headers['X-SDK-Offline'] = 'true';
    }

    while (true) {
      try {
        // if offline, do offline stuff
        print('checking offline status...');

        final routeMatch = _router.match(
          params.method.name(),
          params.path,
        );

        final modelPattern = routeMatch?.getLabel('offline.model') as String;

        final pathValues = routeMatch?.getPathValues(params.path);

        String replacePlaceholder(
            String input, Map<String, String>? pathValues) {
          if (!input.startsWith('{') || !input.endsWith('}')) {
            return input;
          }
          return pathValues![input.substring(1, input.length - 1)]!;
        }

        final model = modelPattern.split('/').map((part) {
          return replacePlaceholder(part, pathValues);
        }).join('/');

        final keyPattern = routeMatch?.getLabel('offline.key') ?? '';
        final key = replacePlaceholder(
          keyPattern,
          pathValues,
        );

        final containerKeyPattern =
            routeMatch?.getLabel('offline.container-key') ?? '';
        final containerKey = replacePlaceholder(
          containerKeyPattern,
          pathValues,
        );

        final cacheParams = CacheParams(
          model: model,
          key: key,
          responseIdKey: routeMatch?.getLabel('offline.response-key') as String,
          responseContainerKey: containerKey,
        );

        final uri = Uri.parse(endpoint + params.path);

        http.BaseRequest request = prepareRequest(
          params.method,
          uri: Uri.parse(endpoint + params.path),
          headers: params.headers,
          params: params.params,
        );

        if (offlinePersistency && !isOnline.value) {
          await checkOnlineStatus();
        }

        if (cacheParams.model.isNotEmpty &&
            offlinePersistency &&
            !isOnline.value &&
            params.responseType != ResponseType.bytes) {
          return handleOfflineRequest(
            uri: uri,
            method: params.method,
            call: this._call,
            path: params.path,
            headers: params.headers,
            params: params.params,
            responseType: params.responseType,
            cacheModel: cacheParams.model,
            cacheKey: cacheParams.key,
            cacheResponseIdKey: cacheParams.responseIdKey,
            cacheResponseContainerKey: cacheParams.responseContainerKey,
          );
        }

        final response = await next.handleCall(params);

        if (offlinePersistency) {
          // cache stuff
          print('cached stuff...');

          final relationsHeader = response.headers['x-appwrite-relations'];
          if (relationsHeader != null) {
            final relations = (jsonDecode(relationsHeader) as List)
                .cast<Map<String, dynamic>>();
            await cacheCollections(relations);
          }
          cacheResponse(
            cacheModel: cacheParams.model,
            cacheKey: cacheParams.key,
            cacheResponseIdKey: cacheParams.responseIdKey,
            cacheResponseContainerKey: cacheParams.responseContainerKey,
            requestMethod: request.method,
            responseData: response.data,
          );
        }

        return response;
      } on AppwriteException catch (e) {
        if ((e.message != "Network is unreachable" &&
                !(e.message?.contains("Failed host lookup") ?? false)) ||
            !offlinePersistency) {
          rethrow;
        }
        isOnline.value = false;
      } on SocketException catch (_) {
        if (!offlinePersistency) {
          rethrow;
        }
        isOnline.value = false;
      } catch (e, s) {
        print(s);
        throw AppwriteException(e.toString());
      }
    }
  }
}