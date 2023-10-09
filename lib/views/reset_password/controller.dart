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
      final loginAccountProvider = FutureProvider.autoDispose(
        (ref) => PostRequest.resetPassword(
          otp: otp.text,
          pin: pin.text,
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
                perform: () => context.goNamed(LoginScreen.name),
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

  void resendToken() async {
    isLoading.value = true;
    final loginAccountProvider = FutureProvider.autoDispose(
      (ref) {
        var email = LocalStorage.instance.getEmail();
        return PostRequest.forgotPassword(
          email: email,
        );
      },
    );
    ref.listenManual(
      loginAccountProvider,
      fireImmediately: false,
      (previous, next) {
        next.when(
          data: (data) {
            startTimer();
            isLoading.value = false;
            ShowFlushBar.showSuccess(
              context: context,
              message: data,
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
