part of 'controller.dart';

class LoginView extends StatelessView<LoginScreen, LoginController> {
  const LoginView(LoginController state, {Key? key}) : super(state, key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(),
      body: ListView(
        padding: [16, 16, 16, 0].pad,
        children: [
          Text(
            'Log in',
            style: CustomTextStyle.text700_20,
          ),
          32.verticalSpace,
          const CustomTextInput(
            titleText: 'Phone number*',
            hintText: '000-000-000',
          ),
          32.verticalSpace,
          ValueListenableBuilder(
            valueListenable: controller.showPin,
            builder: (context, state, _) {
              return CustomTextInput(
                titleText: 'Create pin*',
                hintText: '123456',
                obscureText: state,
                suffixIcon: SvgButton(
                  icon: state ? AppSvg.eye : AppSvg.eyeOpen,
                  onTap: () => controller.showPin.value = !state,
                ),
              );
            },
          ),
          23.verticalSpace,
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Forgot Pin ?',
              style: CustomTextStyle.text600_14.withColor(
                AppColor.grey30,
              ),
            ),
          ),
          324.verticalSpace,
          ValueListenableBuilder(
            valueListenable: controller.isLoading,
            builder: (context, state, _) {
              return Center(
                child: LoadingButton(
                  isLoading: state,
                  normal: AppButton(
                    text: 'LOG IN',
                    onTap: controller.login,
                  ),
                ),
              );
            },
          ),
          24.verticalSpace,
          Center(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Haven\'t registered yet ?',
                    style: CustomTextStyle.text400_16.withColor(
                      AppColor.grey100,
                    ),
                  ),
                  TextSpan(
                    text: ' Create account',
                    style: CustomTextStyle.text700_16.withColor(
                      AppColor.red60,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap =
                          () => context.pushReplacementNamed(SignupScreen.name),
                  ),
                ],
              ),
            ),
          ),
          28.verticalSpace,
        ],
      ),
    );
  }
}
