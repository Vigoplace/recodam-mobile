part of 'controller.dart';

class OnboardingView
    extends StatelessView<OnboardingScreen, OnboardingController> {
  const OnboardingView(super.state, {super.key});

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
                      31.verticalSpacing,
                      Text(
                        'Recodam',
                        style: TextStyle(
                          color: AppColor.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 32.spMin,
                        ),
                      ),
                      10.verticalSpacing,
                      Container(
                        height: 2,
                        width: 150,
                        color: AppColor.red70,
                      ),
                      32.verticalSpacing,
                      Center(
                        child: Text(
                          "Keep track of your spending and keep your records straight.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColor.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 20.spMin,
                          ),
                        ),
                      ),
                      const Spacer(),
                      AppButton(
                        text: 'CREATE ACCOUNT',
                        onTap: () => context.pushNamed(SignupScreen.name),
                      ),
                      28.verticalSpacing,
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Already have an account ?',
                              style: TextStyle(
                                color: AppColor.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 17.spMin,
                              ),
                            ),
                            TextSpan(
                              text: ' Log in',
                              style: TextStyle(
                                color: AppColor.red30,
                                fontWeight: FontWeight.w400,
                                fontSize: 16.spMin,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap =
                                    () => context.pushNamed(LoginScreen.name),
                            ),
                          ],
                        ),
                      ),
                      70.verticalSpacing,
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
