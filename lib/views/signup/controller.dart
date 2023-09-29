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
  late TextEditingController name;
  late TextEditingController email;
  late TextEditingController phone;
  late TextEditingController pin;
  late TextEditingController confirm;

  void create() async {
    isLoading.value = true;

    final createAccountProvider = FutureProvider.autoDispose(
      (ref) => PostRequest.createAccount(
        createAccountModel: CreateAccountModel(
          email: email.text,
          name: name.text,
          password: pin.text,
          phone: phone.text,
        ),
      ),
    );

    ref.listenManual(
      createAccountProvider,
      fireImmediately: false,
      (previous, next) {
        next.when(
          data: (data) {
            debugPrint('LOADED');
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

  @override
  void initState() {
    super.initState();
    name = TextEditingController();
    email = TextEditingController();
    phone = TextEditingController();
    pin = TextEditingController();
    confirm = TextEditingController();
  }

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    phone.dispose();
    pin.dispose();
    confirm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SignupView(this);
  }
}
