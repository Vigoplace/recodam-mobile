import 'package:recordam/utils/utils.dart';
part 'view.dart';

class ChangePinScreen extends StatefulWidget {
  static const path = "change_pin";
  static const name = "change_pin";
  const ChangePinScreen({super.key});

  @override
  State<ChangePinScreen> createState() => ChangePinController();
}

class ChangePinController extends State<ChangePinScreen> {
  late TextEditingController oldPin;
  late TextEditingController newPin;
  late TextEditingController confirmPin;
  var isLoading = ValueNotifier(false);

  bool submitted = false;
  var key = GlobalKey<FormState>();
  var cancelToken = CancelToken();

  void update() async {
    submitted = true;
    setState(() {});
    if (key.currentState!.validate()) {
      isLoading.value = true;
      PostRequest.instance
          .updatePin(
        oldPassword: oldPin.text,
        newPassword: newPin.text,
        cancelToken: cancelToken,
      )
          .then((data) {
        isLoading.value = false;
        ShowFlushBar.showSuccess(message: data);
      }).catchError((error) {
        isLoading.value = false;
        listenError(error: error);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    newPin = TextEditingController();
    oldPin = TextEditingController();
    confirmPin = TextEditingController();
  }

  @override
  void dispose() {
    newPin.dispose();
    oldPin.dispose();
    confirmPin.dispose();
    cancelToken.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangePinView(this);
  }
}
