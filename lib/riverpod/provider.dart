// import 'dart:async';

// import 'package:recordam/utils/utils.dart';

import 'package:recordam/utils/utils.dart';

final loginProvider = FutureProvider.autoDispose((ref) => PostRequest.test());
final homeBookProvider = FutureProvider((ref) => PostRequest.test());
final homeRecordProvider = FutureProvider((ref) => PostRequest.test());
