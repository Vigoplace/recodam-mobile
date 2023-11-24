import 'package:flutter/gestures.dart';
import 'package:recordam/utils/utils.dart';
part 'view.dart';

class OnboardingScreen extends StatefulWidget {
  static const path = "/onboarding";
  static const name = "onboarding";
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => OnboardingController();
}

class OnboardingController extends State<OnboardingScreen> {
  @override
  void initState() {
    super.initState();
    LocalStorage.instance.setFirstTime();
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingView(this);
  }
}
