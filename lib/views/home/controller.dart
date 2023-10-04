import 'package:recordam/utils/utils.dart';
part 'view.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const path = "/home";
  static const name = "home";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => HomeController();
}

class HomeController extends ConsumerState<HomeScreen> {
  var acceptedTerms = ValueNotifier(false);
  var showPin = ValueNotifier(false);
  late String name;

  @override
  void initState() {
    super.initState();
    name = LocalStorage.instance.getName();
    SocketServices.instance.connectAndListen(ref);
  }

  @override
  Widget build(BuildContext context) {
    return HomeView(this);
  }
}
