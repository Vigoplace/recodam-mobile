import 'package:flutter/gestures.dart';
import 'package:recordam/utils/utils.dart';
part 'view.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const path = "/login";
  static const name = "login";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => LoginController();
}

class LoginController extends ConsumerState<LoginScreen> {
  var acceptedTerms = ValueNotifier(false);
  var showPin = ValueNotifier(false);
  var isLoading = ValueNotifier(false);

  void login() async {
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
    return LoginView(this);
  }
}
