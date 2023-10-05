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
  late TextEditingController phone;
  late TextEditingController pin;

  bool submitted = false;
  var key = GlobalKey<FormState>();

  void login() async {
    submitted = true;
    setState(() {});
    if (key.currentState!.validate()) {
      isLoading.value = true;
      final loginAccountProvider = FutureProvider.autoDispose(
        (ref) => PostRequest.loginToAccount(
          loginModel: LoginModel(
            password: pin.text,
            phone: phone.text,
          ),
        ),
      );
      ref.listenManual(
        loginAccountProvider,
        fireImmediately: false,
        (previous, next) {
          next.when(
            data: (data) {
              isLoading.value = false;
              ShowFlushBar.showSuccess(
                context: context,
                message: data.message,
                perform: () async {
                  LocalStorage.instance
                      .saveUserInfo(data.data)
                      .whenComplete(() => context.goNamed(HomeScreen.name));
                },
              );
            },
            error: (error, trace) {
              isLoading.value = false;
              listenError(context: context, error: error);
            },
            loading: () => debugPrint('LOADING'),
          );
        },
      );
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoginView(this);
  }
}
