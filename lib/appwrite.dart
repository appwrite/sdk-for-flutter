library appwrite;

import 'dart:async';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'src/redirect_stub.dart'
    if (dart.library.html) 'src/redirect_browser.dart';
import 'src/enums.dart';
import 'src/client.dart';
import 'src/service.dart';
import 'models.dart' as models;

export 'src/response.dart';
export 'src/client.dart';
export 'src/exception.dart';
export 'src/realtime.dart';
export 'src/realtime_subscription.dart';
export 'src/realtime_message.dart';
export 'package:http/http.dart' show MultipartFile;

part 'query.dart';
part 'services/account.dart';
part 'services/avatars.dart';
part 'services/database.dart';
part 'services/functions.dart';
part 'services/locale.dart';
part 'services/storage.dart';
part 'services/teams.dart';
