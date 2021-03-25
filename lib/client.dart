part of appwrite;

class Client {
    String endPoint;
    String type = 'unknown';
    Map<String, String> headers;
    Map<String, String> config;
    bool selfSigned;
    bool initialized = false;
    Dio http;
    PersistCookieJar cookieJar;

    Client({this.endPoint = 'https://appwrite.io/v1', this.selfSigned = false, Dio http}) : this.http = http ?? Dio() {
        // Platform is not supported in web so if web, set type to web automatically and skip Platform check
        if(kIsWeb) {
            type = 'web';
        }else{
            type = (Platform.isIOS) ? 'ios' : type;
            type = (Platform.isMacOS) ? 'macos' : type;
            type = (Platform.isAndroid) ? 'android' : type;
            type = (Platform.isLinux) ? 'linux' : type;
            type = (Platform.isWindows) ? 'windows' : type;
            type = (Platform.isFuchsia) ? 'fuchsia' : type;
        }
        
        this.headers = {
            'content-type': 'application/json',
            'x-sdk-version': 'appwrite:flutter:0.4.0',
        };

        this.config = {};

        assert(endPoint.startsWith(RegExp("http://|https://")), "endPoint $endPoint must start with 'http'");
    }
    
    Future<Directory> _getCookiePath() async {
        final directory = await getApplicationDocumentsDirectory();
        final path = directory.path;
        final Directory dir = new Directory('$path/cookies');
        await dir.create();
        return dir;
    }

     /// Your project ID
    Client setProject(value) {
        config['project'] = value;
        addHeader('X-Appwrite-Project', value);
        return this;
    }

    Client setLocale(value) {
        config['locale'] = value;
        addHeader('X-Appwrite-Locale', value);
        return this;
    }

    Client setSelfSigned({bool status = true}) {
        selfSigned = status;
        return this;
    }

    Client setEndpoint(String endPoint) {
        this.endPoint = endPoint;
        this.http.options.baseUrl = this.endPoint;
        return this;
    }

    Client addHeader(String key, String value) {
        headers[key] = value;
        
        return this;
    }

    Future init() async {
        if(!initialized) {
          // if web skip cookie implementation and origin header as those are automatically handled by browsers
          if(!kIsWeb) {
            final Directory cookieDir = await _getCookiePath();
            cookieJar = new PersistCookieJar(dir:cookieDir.path);
            this.http.interceptors.add(CookieManager(cookieJar));
            PackageInfo packageInfo = await PackageInfo.fromPlatform();
            addHeader('Origin', 'appwrite-$type://${packageInfo.packageName ?? packageInfo.appName}');
          }else{
            // if web set httpClientAdapter as BrowserHttpClientAdapter with withCredentials true to make cookies work
            this.http.options.extra['withCredentials'] = true;
          }

          this.http.options.baseUrl = this.endPoint;
          this.http.options.validateStatus = (status) => status < 400;
        }
    }

    Future<Response> call(HttpMethod method, {String path = '', Map<String, String> headers = const {}, Map<String, dynamic> params = const {}, ResponseType responseType}) async {
        if(selfSigned && !kIsWeb) {
            // Allow self signed requests
            (http.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
                client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
                return client;
            };
        }

        await this.init();

        // Origin is hardcoded for testing
        Options options = Options(
            headers: {...this.headers, ...headers},
            method: method.name(),
            responseType: responseType
        );

        try {
            if(headers['content-type'] == 'multipart/form-data') {
                return await http.request(path, data: FormData.fromMap(params), options: options);
            }

            if (method == HttpMethod.get) {
                params.keys.forEach((key) {if (params[key] is int || params[key] is double) {
                params[key] = params[key].toString();
                }});
                
                return await http.get(path, queryParameters: params, options: options);
            } else {
                return await http.request(path, data: params, options: options);
            }
        } on DioError catch(e) {
          if(e.response == null) {
            throw AppwriteException(e.message);
          }
          if(responseType == ResponseType.bytes) {
            if(e.response.headers['content-type'].contains('application/json')) {
              final res = json.decode(utf8.decode(e.response.data));
              throw AppwriteException(res['message'],res['code'], e.response);
            } else {
              throw AppwriteException(e.message);
            }
          }
          throw AppwriteException(e.response.data['message'],e.response.data['code'], e.response.data);
        } catch(e) {
          throw AppwriteException(e.message);
        }
    }
}
