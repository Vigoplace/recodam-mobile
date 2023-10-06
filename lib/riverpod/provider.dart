// import 'dart:async';

// import 'package:recordam/utils/utils.dart';

import 'package:recordam/utils/utils.dart';

final loginProvider = FutureProvider.autoDispose((ref) => PostRequest.test());
final homeBookProvider = FutureProvider((ref) => GetRequest.getAllBooks());
final homeRecordProvider = FutureProvider((ref) => PostRequest.test());
final sendingProvider = StateProvider((ref) => false);
