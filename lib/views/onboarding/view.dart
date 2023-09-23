part of 'controller.dart';

class OnboardingView
    extends StatelessView<OnboardingScreen, OnboardingController> {
  const OnboardingView(OnboardingController state, {Key? key})
      : super(state, key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.white),
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                AppImages.onboarding,
                fit: BoxFit.fill,
              ),
            ),
            Positioned.fill(
              child: SafeArea(
                child: Padding(
                  padding: [21, 0].pad,
                  child: Column(
                    children: [
                      31.verticalSpace,
                      Text(
                        'Recodam',
                        style: CustomTextStyle.text700_32.withColor(
                          AppColor.white,
                        ),
                      ),
                      10.verticalSpace,
                      Container(
                        height: 2.h,
                        width: 150.w,
                        color: AppColor.red70,
                      ),
                      32.verticalSpace,
                      Center(
                        child: Text(
                          "Keep track of your spending and keep your records straight.",
                          textAlign: TextAlign.center,
                          style: CustomTextStyle.text700_20.withColor(
                            AppColor.white,
                          ),
                        ),
                      ),
                      const Spacer(),
                      AppButton(
                        text: 'CREATE ACCOUNT',
                        onTap: () => context.pushNamed(SignupScreen.name),
                      ),
                      28.verticalSpace,
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Already have an account ?',
                              style: CustomTextStyle.text700_16.withColor(
                                AppColor.white,
                              ),
                            ),
                            TextSpan(
                              text: ' Log in',
                              style: CustomTextStyle.text400_16.withColor(
                                AppColor.red30,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap =
                                    () => context.pushNamed(LoginScreen.name),
                            ),
                          ],
                        ),
                      ),
                      70.verticalSpace,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
