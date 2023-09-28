
import 'package:another_flushbar/flushbar.dart';
import 'package:recordam/utils/utils.dart';
part 'view.dart';

class HomeScreen extends StatefulWidget {
  static const path = "/home";
  static const name = "home";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => HomeController();
}

class HomeController extends State<HomeScreen> {
  var acceptedTerms = ValueNotifier(false);
  var showPin = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return HomeView(this);
  }
}
