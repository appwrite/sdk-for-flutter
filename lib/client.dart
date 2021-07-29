part of appwrite;

class Client {
    String endPoint;
    String type = 'unknown';
    Map<String, String>? headers;
    late Map<String, String> config;
    bool selfSigned;
    bool initialized = false;
    Dio http;
    late PersistCookieJar cookieJar;
    late SharedPreferences _prefs;

    Client({this.endPoint = 'https://appwrite.io/v1', this.selfSigned = false, Dio? http}) : this.http = http ?? Dio() {
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
            'x-sdk-version': 'appwrite:flutter:0.7.1',
            'X-Appwrite-Response-Format' : '0.9.0',
        };

        this.config = {};

        assert(endPoint.startsWith(RegExp("http://|https://")), "endPoint $endPoint must start with 'http'");
        init();
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

     /// Your secret JSON Web Token
    Client setJWT(value) {
        config['jWT'] = value;
        addHeader('X-Appwrite-JWT', value);
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
        headers![key] = value;
        
        return this;
    }

    Future init() async {
        // if web skip cookie implementation and origin header as those are automatically handled by browsers
        if(!kIsWeb) {
            final Directory cookieDir = await _getCookiePath();
            cookieJar = new PersistCookieJar(storage: FileStorage(cookieDir.path));
            this.http.interceptors.add(CookieManager(cookieJar));
            PackageInfo packageInfo = await PackageInfo.fromPlatform();
            addHeader('Origin', 'appwrite-$type://${packageInfo.packageName}');

            //creating custom user agent
            DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
            var device = '';
            if (Platform.isAndroid) {
                final andinfo = await deviceInfoPlugin.androidInfo;
                device =
                    '(Linux; U; Android ${andinfo.version.release}; ${andinfo.brand} ${andinfo.model})';
            }
            if (Platform.isIOS) {
                final iosinfo = await deviceInfoPlugin.iosInfo;
                device = '${iosinfo.utsname.machine} iOS/${iosinfo.systemVersion}';
            }
            if (Platform.isLinux) {
                final lininfo = await deviceInfoPlugin.linuxInfo;
                device = '(Linux; U; ${lininfo.id} ${lininfo.version})';
            }
            if (Platform.isWindows) {
                final wininfo = await deviceInfoPlugin.windowsInfo;
                device =
                    '(Windows NT; ${wininfo.computerName})'; //can't seem to get much info here
            }
            if (Platform.isMacOS) {
                final macinfo = await deviceInfoPlugin.macOsInfo;
                device = '(Macintosh; ${macinfo.model})';
            }
            addHeader('user-agent', '${packageInfo.packageName}/${packageInfo.version} $device');
        } else {
            // if web set withCredentials true to make cookies work
            _prefs = await SharedPreferences.getInstance();
            addHeader('X-Fallback-Cookies', _prefs.getString('cookieFallback') ?? '');
            this.http.options.extra['withCredentials'] = true;
        }

        this.http.options.baseUrl = this.endPoint;
        this.http.options.validateStatus = (status) => status! < 400;
        initialized = true;
    }

    Future<Response> call(HttpMethod method, {String path = '', Map<String, String> headers = const {}, Map<String, dynamic> params = const {}, ResponseType? responseType}) async {
        if(selfSigned && !kIsWeb) {
            // Allow self signed requests
            (http.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
                client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
                return client;
            };
        }

        if(!initialized) {
            await this.init();
        }

        if(params.isNotEmpty) {
            params.removeWhere((key,value) => value == null);
        }

        // Origin is hardcoded for testing
        Options options = Options(
            headers: {...this.headers!, ...headers},
            method: method.name(),
            responseType: responseType,
            listFormat: ListFormat.multiCompatible
        );

        late Response res;
        try {
            if(headers['content-type'] == 'multipart/form-data') {
                res = await http.request(path, data: FormData.fromMap(params, ListFormat.multiCompatible), options: options);
            } else if (method == HttpMethod.get) {
                params.keys.forEach((key) {if (params[key] is int || params[key] is double) {
                params[key] = params[key].toString();
                }});
                
                res = await http.get(path, queryParameters: params, options: options);
            } else {
                res = await http.request(path, data: params, options: options);
            }
            if(kIsWeb) {
                final cookieFallback = res.headers.value('X-Fallback-Cookies');
                if(cookieFallback != null) {
                    print('Appwrite is using localStorage for session management. Increase your security by adding a custom domain as your API endpoint.');
                    addHeader('X-Fallback-Cookies',cookieFallback);
                    _prefs.setString('cookieFallback', cookieFallback);
                }
            }
            return res;
        } on DioError catch(e) {
          if(e.response == null) {
            throw AppwriteException(e.message);
          }
          if(responseType == ResponseType.bytes) {
            if ((e.response!.headers.value('content-type') ?? '').contains('application/json')) {
              final res = json.decode(utf8.decode(e.response!.data));
              throw AppwriteException(res['message'],res['code'], e.response);
            } else {
              throw AppwriteException(e.message);
            }
          }
          if ((e.response!.headers.value('content-type') ?? '').contains('application/json')) {
            throw AppwriteException(e.response!.data['message'],e.response!.data['code'], e.response!.data);
          } else {
            throw AppwriteException(e.response!.data,e.response!.statusCode, e.response!.data);
          }
        } catch(e) {
          throw AppwriteException(e.toString());
        }
    }
}
