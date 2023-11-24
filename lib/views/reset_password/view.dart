part of 'controller.dart';

class ResetPasswordView
    extends StatelessView<ResetPasswordScreen, ResetPasswordController> {
  const ResetPasswordView(super.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(),
      body: Form(
        key: controller.key,
        child: ListView(
          padding: [16, 16, 16, 0].pad,
          children: [
            Text(
              'Reset password',
              style: TextStyle(
                color: AppColor.grey100,
                fontWeight: FontWeight.w700,
                fontSize: 20.sp,
              ),
            ),
            32.verticalSpace,
            CustomTextInput(
              controller: controller.otp,
              titleText: 'OTP*',
              hintText: '1234',
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              autovalidateMode: controller.submitted
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
              validator: (p0) {
                if (p0 == null || p0.isEmpty) {
                  return 'Please, enter a OTP code';
                }
                return null;
              },
            ),
            32.verticalSpace,
            CustomTextInput(
              controller: controller.pin,
              titleText: 'New pin*',
              hintText: '123456',
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              autovalidateMode: controller.submitted
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
              validator: (p0) {
                if (p0 == null || p0.isEmpty) {
                  return 'Please, enter a new pin';
                }
                return null;
              },
            ),
            32.verticalSpace,
            CustomTextInput(
              controller: controller.confirmPin,
              titleText: 'Confirm pin*',
              keyboardType: TextInputType.number,
              hintText: '123456',
              autovalidateMode: controller.submitted
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please confirm your password';
                } else if (value.length != 6) {
                  return 'Password length must be 6 characters';
                } else if (controller.confirmPin.text != controller.pin.text) {
                  return 'Password mismatch';
                }
                return null;
              },
            ),
            23.verticalSpace,
            Align(
              alignment: Alignment.centerRight,
              child: ValueListenableBuilder(
                  valueListenable: controller.showResend,
                  builder: (context, value, _) {
                    return InkWell(
                      overlayColor: MaterialStateColor.resolveWith(
                        (states) => Colors.transparent,
                      ),
                      onTap: () {
                        if (value) {
                          controller.showResend.value = false;
                          controller.resendToken();
                        }
                      },
                      child: ValueListenableBuilder(
                          valueListenable: controller.timeNotifier,
                          builder: (context, timer, _) {
                            String text = '';
                            var duration = Duration(
                                seconds: controller.duration.inSeconds - timer);
                            if (duration.inSeconds == 0) {
                              text = '';
                            } else {
                              int minutes = duration.inSeconds ~/ 60;
                              int seconds = duration.inSeconds % 60;
                              text = ' in ${minutes}m:${seconds}s';
                            }
                            return Text(
                              'Resend token$text',
                              style: TextStyle(
                                color: value ? AppColor.red60 : AppColor.grey30,
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                              ),
                            );
                          }),
                    );
                  }),
            ),
            230.verticalSpace,
            ValueListenableBuilder(
              valueListenable: controller.isLoading,
              builder: (context, state, _) {
                return Center(
                  child: LoadingButton(
                    isLoading: state,
                    normal: AppButton(
                      text: 'Confirm',
                      onTap: controller.login,
                    ),
                  ),
                );
              },
            ),
            24.verticalSpace,
          ],
        ),
      ),
    );
  }
}
