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
      final loginAccountProvider = FutureProvider.autoDispose(
        (ref) => PostRequest.forgotPassword(
          email: email.text,
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
                message: data,
                perform: () async {
                  LocalStorage.instance.setEmail(email.text).whenComplete(
                      () => context.replaceNamed(ResetPasswordScreen.name));
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
