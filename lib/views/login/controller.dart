import 'package:flutter/gestures.dart';
import 'package:recordam/utils/utils.dart';
part 'view.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const path = "/login";
  static const name = "login";
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => LoginController();
}

class LoginController extends ConsumerState<LoginScreen> {
  var acceptedTerms = ValueNotifier(false);
  var showPin = ValueNotifier(false);
  var isLoading = ValueNotifier(false);
  late TextEditingController phone;
  late TextEditingController pin;

  bool submitted = false;
  var key = GlobalKey<FormState>();
  var cancelToken = CancelToken();

  void login() async {
    submitted = true;
    setState(() {});
    if (key.currentState!.validate()) {
      isLoading.value = true;
      PostRequest.instance
          .loginToAccount(
        loginModel: LoginModel(
          password: pin.text,
          phone: phone.text,
        ),
        cancelToken: cancelToken,
      )
          .then((data) {
        if (mounted) {
          isLoading.value = false;
          ShowFlushBar.showSuccess(
            message: data.message,
            perform: () async {
              LocalStorage.instance
                  .saveUserInfo(data.data)
                  .whenComplete(() => context.goNamed(HomeScreen.name));
            },
          );
        }
      }).catchError((error) {
        if (mounted) {
          isLoading.value = false;
          listenError(error: error);
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    phone = TextEditingController();
    pin = TextEditingController();
  }

  @override
  void dispose() {
    phone.dispose();
    pin.dispose();
    cancelToken.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoginView(this);
  }
}
