import 'package:recordam/utils/utils.dart';
part 'view.dart';

class ChangePinScreen extends StatefulWidget {
  static const path = "change_pin";
  static const name = "change_pin";
  const ChangePinScreen({Key? key}) : super(key: key);

  @override
  State<ChangePinScreen> createState() => ChangePinController();
}

class ChangePinController extends State<ChangePinScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangePinView(this);
  }
}
