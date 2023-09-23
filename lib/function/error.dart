//  bool? Function(Object, StackTrace)

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:recordam/utils/utils.dart';

void errorFuntions(
  Object error,
  StackTrace trace, {
  required BuildContext context,
}) {
  if (error is SocketException) {
    ShowFlushBar.showError(
      'Check your internet connection',
      context: context,
    );
  } else if (error is DioException) {
    var message = 'Something went wrong';
    if (error.response?.data is Map &&
        (error.response?.data as Map).containsKey('message')) {
      message = error.response?.data['message'];
    }
    ShowFlushBar.showError(
      message,
      context: context,
    );
  } else {
    ShowFlushBar.showError(
      'Fatal error',
      context: context,
    );
  }
}
