import 'package:recordam/utils/utils.dart';

void listenError({required Object error}) {
  debugPrint('$error');
  if (error is DioException) {
    if (error.response != null && error.response?.data is Map) {
      var err = CustomError.fromJson(error.response?.data);
      ShowFlushBar.showError(err.message);
    } else {
      ShowFlushBar.showError('Check your internet connection');
    }
  } else {
    ShowFlushBar.showError('Something went wrong');
  }
}
