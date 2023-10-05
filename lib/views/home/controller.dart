import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:recordam/utils/utils.dart';
import 'package:recordam/views/all_books/controller.dart';
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
  late RefreshController refreshController;

  @override
  void initState() {
    super.initState();
    name = LocalStorage.instance.getName();
    refreshController = RefreshController();
    SocketServices.instance.connectAndListen(ref);
  }

  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HomeView(this);
  }
}
