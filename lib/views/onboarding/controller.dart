import 'package:recordam/utils/utils.dart';
part 'view.dart';

class OnboardingScreen extends StatefulWidget {
  static const path = "/test";
  static const name = "test";
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => OnboardingController();
}

class OnboardingController extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return OnboardingView(this);
  }
}
