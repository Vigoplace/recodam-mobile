import 'package:another_flushbar/flushbar.dart';
import 'package:recordam/utils/utils.dart';

class ShowFlushBar {
  static void showError(
    String? error, {
    Duration? duration,
    void Function()? perform,
  }) async {
    final flushBar = Flushbar(
      backgroundColor: Colors.red.withOpacity(0.8),
      borderColor: Colors.red,
      borderRadius: BorderRadius.circular(8.r),
      margin: EdgeInsets.symmetric(horizontal: 8.w),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      messageText: Text(
        error ?? 'Something went wrong',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColor.white,
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ),
      ),
      positionOffset: kBottomNavigationBarHeight.h,
      duration: duration ?? const Duration(seconds: 3),
    );
    flushBar.show(routes.routerDelegate.navigatorKey.currentContext!);
    await Future.delayed(const Duration(seconds: 1));
    flushBar.dismiss();
    if (perform != null) {
      perform();
    }
  }

  static void showSuccess({
    String? message,
    Duration? duration,
    void Function()? perform,
  }) async {
    final flushBar = Flushbar(
      backgroundColor: Colors.green.withOpacity(0.8),
      borderColor: Colors.green,
      borderRadius: BorderRadius.circular(8.r),
      margin: EdgeInsets.symmetric(horizontal: 8.w),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      messageText: Text(
        message ?? 'Successful',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColor.white,
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ),
      ),
      positionOffset: kBottomNavigationBarHeight.h,
      duration: duration ?? const Duration(seconds: 3),
    );
    flushBar.show(routes.routerDelegate.navigatorKey.currentContext!);
    await Future.delayed(const Duration(seconds: 1));
    flushBar.dismiss();
    if (perform != null) {
      perform();
    }
  }

  static void showDialogError(String message) async {
    showDialog(
      context: routes.routerDelegate.navigatorKey.currentContext!,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Padding(
            padding: [10].pad,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                20.verticalSpace,
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15.sp,
                  ),
                ),
                10.verticalSpace,
                AppButton(
                  text: 'Close',
                  onTap: () => Navigator.of(context).pop(),
                ),
                20.verticalSpace,
              ],
            ),
          ),
        );
      },
    );
  }
}
