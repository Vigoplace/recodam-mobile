part of 'controller.dart';

class SignupView extends StatelessView<SignupScreen, SignupController> {
  const SignupView(SignupController state, {Key? key}) : super(state, key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(),
      body: ListView(
        padding: [16, 16, 16, 0].pad,
        children: [
          Text(
            'Create Account',
            style: CustomTextStyle.text700_20,
          ),
          32.verticalSpace,
          const CustomTextInput(
            titleText: 'Full Name*',
            hintText: 'Individual or organization',
          ),
          32.verticalSpace,
          const CustomTextInput(
            titleText: 'Email',
            hintText: 'example@gmail.com',
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
          32.verticalSpace,
          ValueListenableBuilder(
            valueListenable: controller.showConfirmPin,
            builder: (context, state, _) {
              return CustomTextInput(
                titleText: 'Confirm pin*',
                hintText: '123456',
                obscureText: state,
                suffixIcon: SvgButton(
                  icon: state ? AppSvg.eye : AppSvg.eyeOpen,
                  onTap: () => controller.showConfirmPin.value = !state,
                ),
              );
            },
          ),
          32.verticalSpace,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ValueListenableBuilder(
                valueListenable: controller.acceptedTerms,
                builder: (context, state, _) {
                  return SvgButton(
                    icon: state ? AppSvg.checked : AppSvg.checkmark,
                    onTap: () => controller.acceptedTerms.value = !state,
                  );
                },
              ),
              8.horizontalSpace,
              Expanded(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'By tapping create an account and using',
                        style: CustomTextStyle.text400_14,
                      ),
                      TextSpan(
                        text: ' Recodam ',
                        style: CustomTextStyle.text500_14,
                      ),
                      TextSpan(
                        text: 'you agree to our',
                        style: CustomTextStyle.text400_14,
                      ),
                      TextSpan(
                        text: ' Terms ',
                        style: CustomTextStyle.text500_14,
                      ),
                      TextSpan(
                        text: 'and',
                        style: CustomTextStyle.text400_14,
                      ),
                      TextSpan(
                        text: ' Privacy policy ',
                        style: CustomTextStyle.text500_14,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          43.verticalSpace,
          ValueListenableBuilder(
            valueListenable: controller.isLoading,
            builder: (context, state, _) {
              return Center(
                child: LoadingButton(
                  isLoading: state,
                  normal: AppButton(
                    text: 'CREATE ACCOUNT',
                    onTap: controller.create,
                  ),
                ),
              );
            },
          ),
          40.verticalSpace,
          Center(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Have an account ?',
                    style: CustomTextStyle.text400_16.withColor(
                      AppColor.grey100,
                    ),
                  ),
                  TextSpan(
                    text: ' Sign in',
                    style: CustomTextStyle.text700_16.withColor(
                      AppColor.red60,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap =
                          () => context.pushReplacementNamed(LoginScreen.name),
                  ),
                ],
              ),
            ),
          ),
          40.verticalSpace,
        ],
      ),
    );
  }
}
