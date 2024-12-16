part of 'controller.dart';

class ForgotPasswordView
    extends StatelessView<ForgotPasswordScreen, ForgotPasswordController> {
  const ForgotPasswordView(super.state, {super.key});

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
              'Forgot password',
              style: TextStyle(
                color: AppColor.grey100,
                fontWeight: FontWeight.w700,
                fontSize: 20.spMin,
              ),
            ),
            32.verticalSpacing,
            CustomTextInput(
              controller: controller.email,
              titleText: 'Email*',
              hintText: 'example@gmail.com',
              keyboardType: TextInputType.emailAddress,
              autovalidateMode: controller.submitted
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
              validator: (p0) {
                if (p0 == null || p0.isEmpty) {
                  return 'Please, enter your email';
                }
                return null;
              },
            ),
            450.verticalSpacing,
            ValueListenableBuilder(
              valueListenable: controller.isLoading,
              builder: (context, state, _) {
                return Center(
                  child: LoadingButton(
                    isLoading: state,
                    normal: AppButton(
                      text: 'Proceed',
                      onTap: controller.login,
                    ),
                  ),
                );
              },
            ),
            28.verticalSpacing,
          ],
        ),
      ),
    );
  }
}
