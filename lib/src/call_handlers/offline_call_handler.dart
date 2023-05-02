import 'dart:io';

import 'package:http/http.dart' as http;

import '../call_params.dart';
import '../client_mixin.dart';
import '../client_offline_mixin.dart';
import '../enums.dart';
import '../exception.dart';
import '../offline/caller.dart';
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

  OfflineCallHandler(this._call);

  @override
  Future<Response> handleCall(CallParams params) async {
    final endpoint = getEndpoint(params);
    final offlinePersistency = getOfflinePersistency(params);

    while (true) {
      try {
        // if offline, do offline stuff
        print('checking offline status...');

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

        final cacheParams = getCacheParams(params);

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

        // cache stuff
        print('cached stuff...');
        if (offlinePersistency) {
          cacheResponse(
            cacheModel: cacheParams.model,
            cacheKey: cacheParams.key,
            cacheResponseIdKey: cacheParams.responseIdKey,
            request: request,
            response: response,
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
      } catch (e) {
        throw AppwriteException(e.toString());
      }
    }
  }
}
