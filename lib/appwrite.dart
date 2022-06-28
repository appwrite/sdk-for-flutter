library appwrite;

import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' show MultipartFile;
import 'src/enums.dart';
import 'src/client.dart';
import 'src/service.dart';
import 'src/input_file.dart';
import 'models.dart' as models;
import 'src/upload_progress.dart';
import 'src/exception.dart';

export 'src/response.dart';
export 'src/client.dart';
export 'src/exception.dart';
export 'src/realtime.dart';
export 'src/upload_progress.dart';
export 'src/realtime_subscription.dart';
export 'src/realtime_message.dart';
export 'src/input_file.dart';

part 'query.dart';
part 'services/account.dart';
part 'services/avatars.dart';
part 'services/databases.dart';
part 'services/functions.dart';
part 'services/locale.dart';
part 'services/storage.dart';
part 'services/teams.dart';
