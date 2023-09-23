part of 'controller.dart';

class OnboardingView
    extends StatelessView<OnboardingScreen, OnboardingController> {
  const OnboardingView(OnboardingController state, {Key? key})
      : super(state, key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
      ),
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
                        style: TextStyle(
                          color: AppColor.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 32.sp,
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
                          style: TextStyle(
                            color: AppColor.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 20.sp,
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
                              style: TextStyle(
                                color: AppColor.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 17.sp,
                              ),
                            ),
                            TextSpan(
                              text: ' Log in',
                              style: TextStyle(
                                color: AppColor.red30,
                                fontWeight: FontWeight.w400,
                                fontSize: 16.sp,
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
