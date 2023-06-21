/// Appwrite Flutter SDK
///
/// This SDK is compatible with Appwrite server version 0.13.x. 
/// For older versions, please check
/// [previous releases](https://github.com/appwrite/sdk-for-flutter/releases).
library appwrite;

import 'dart:async';
import 'dart:typed_data';
import 'src/enums.dart';
import 'src/service.dart';
import 'src/input_file.dart';
import 'models.dart' as models;
import 'src/upload_progress.dart';

export 'src/response.dart';
export 'src/client.dart';
export 'src/exception.dart';
export 'src/realtime.dart';
export 'src/upload_progress.dart';
export 'src/realtime_subscription.dart';
export 'src/realtime_message.dart';
export 'src/input_file.dart';

part 'query.dart';
part 'permission.dart';
part 'role.dart';
part 'id.dart';
part 'services/account.dart';
part 'services/avatars.dart';
part 'services/database.dart';
part 'services/functions.dart';
part 'services/locale.dart';
part 'services/storage.dart';
part 'services/teams.dart';
