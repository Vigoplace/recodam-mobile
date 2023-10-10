import 'package:recordam/utils/utils.dart';
part 'view.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  static const path = "forgot_password";
  static const name = "forgot_password";
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      ForgotPasswordController();
}

class ForgotPasswordController extends ConsumerState<ForgotPasswordScreen> {
  var isLoading = ValueNotifier(false);
  late TextEditingController email;

  bool submitted = false;
  var key = GlobalKey<FormState>();

  void login() async {
    submitted = true;
    setState(() {});
    if (key.currentState!.validate()) {
      isLoading.value = true;
      PostRequest.forgotPassword(
        email: email.text,
      ).then((value) {
        isLoading.value = false;
        ShowFlushBar.showSuccess(
          context: context,
          message: value,
          perform: () async {
            LocalStorage.instance.setEmail(email.text).whenComplete(
                () => context.replaceNamed(ResetPasswordScreen.name));
          },
        );
      }).catchError((error) {
        isLoading.value = false;
        listenError(context: context, error: error);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    email = TextEditingController();
  }

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ForgotPasswordView(this);
  }
}
