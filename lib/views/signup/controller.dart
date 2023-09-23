import 'package:flutter/gestures.dart';
import 'package:recordam/utils/utils.dart';
part 'view.dart';

class SignupScreen extends ConsumerStatefulWidget {
  static const path = "/signup";
  static const name = "signup";
  const SignupScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SignupScreen> createState() => SignupController();
}

class SignupController extends ConsumerState<SignupScreen> {
  var acceptedTerms = ValueNotifier(false);
  var showPin = ValueNotifier(false);
  var showConfirmPin = ValueNotifier(false);
  var isLoading = ValueNotifier(false);

  void create() async {
    isLoading.value = true;
    ref.listenManual(
      loginProvider,
      fireImmediately: false,
      (previous, next) {
        next.when(
          data: (data) {
            debugPrint('LOADED');
            isLoading.value = false;
            context.goNamed(HomeScreen.name);
          },
          error: (error, trace) {
            isLoading.value = false;
            debugPrint(error.toString());
          },
          loading: () => debugPrint('LOADING'),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SignupView(this);
  }
}
