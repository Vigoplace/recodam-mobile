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
            style: TextStyle(
              color: AppColor.grey100,
              fontWeight: FontWeight.w700,
              fontSize: 20.sp,
            ),
          ),
          32.verticalSpace,
          CustomTextInput(
            controller: controller.phone,
            titleText: 'Phone number*',
            hintText: '000-000-000',
          ),
          32.verticalSpace,
          ValueListenableBuilder(
            valueListenable: controller.showPin,
            builder: (context, state, _) {
              return CustomTextInput(
                controller: controller.pin,
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
              style: TextStyle(
                color: AppColor.grey30,
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
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
                    style: TextStyle(
                      color: AppColor.grey100,
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                    ),
                  ),
                  TextSpan(
                    text: ' Create account',
                    style: TextStyle(
                      color: AppColor.red60,
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp,
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
