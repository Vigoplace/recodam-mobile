// import 'dart:async';

// import 'package:recordam/utils/utils.dart';

import 'package:recordam/utils/utils.dart';

final loginProvider = FutureProvider.autoDispose((ref) => PostRequest.login());
final homeBookProvider = FutureProvider((ref) => PostRequest.login());
final homeRecordProvider = FutureProvider((ref) => PostRequest.login());
