import 'package:dio/dio.dart';
import 'package:recordam/utils/utils.dart';

void listenError({
  required Object error,
  required BuildContext context,
}) {
  if (error is DioException) {
    if (error.response != null && error.response?.data is Map) {
      var err = CustomError.fromJson(error.response?.data);
      ShowFlushBar.showError(
        err.message,
        context: context,
      );
    } else {
      ShowFlushBar.showError(
        'Check your internet connection',
        context: context,
      );
    }
  } else {
    ShowFlushBar.showError(
      'Something went wrong',
      context: context,
    );
  }
}
