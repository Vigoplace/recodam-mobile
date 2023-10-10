import 'dart:async';

import 'package:recordam/utils/utils.dart';
part 'view.dart';

class ResetPasswordScreen extends ConsumerStatefulWidget {
  static const path = "reset_passeord";
  static const name = "reset_passeord";
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ResetPasswordScreen> createState() => ResetPasswordController();
}

class ResetPasswordController extends ConsumerState<ResetPasswordScreen> {
  var isLoading = ValueNotifier(false);
  var showResend = ValueNotifier(false);
  late TextEditingController pin;
  late TextEditingController confirmPin;
  late TextEditingController otp;
  late Timer timer;
  ValueNotifier<int> timeNotifier = ValueNotifier(0);
  var duration = const Duration(seconds: 120);

  bool submitted = false;
  var key = GlobalKey<FormState>();

  void login() async {
    submitted = true;
    setState(() {});
    if (key.currentState!.validate()) {
      isLoading.value = true;
      PostRequest.resetPassword(
        otp: otp.text,
        pin: pin.text,
      ).then((data) {
        isLoading.value = false;
        ShowFlushBar.showSuccess(
          context: context,
          message: data,
          perform: () => context.goNamed(LoginScreen.name),
        );
      }).catchError((error) {
        isLoading.value = false;
        listenError(context: context, error: error);
      });
    }
  }

  void resendToken() async {
    isLoading.value = true;
    var email = LocalStorage.instance.getEmail();
    PostRequest.forgotPassword(
      email: email,
    ).then((value) {
      startTimer();
      isLoading.value = false;
      ShowFlushBar.showSuccess(
        context: context,
        message: value,
      );
    }).catchError((error) {
      isLoading.value = false;
      listenError(context: context, error: error);
    });
  }

  @override
  void initState() {
    super.initState();
    pin = TextEditingController();
    confirmPin = TextEditingController();
    otp = TextEditingController();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      timeNotifier.value = timer.tick;
      if (timer.tick % duration.inSeconds == 0) {
        timer.cancel();
        showResend.value = true;
      }
    });
  }

  @override
  void dispose() {
    pin.dispose();
    confirmPin.dispose();
    otp.dispose();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResetPasswordView(this);
  }
}
