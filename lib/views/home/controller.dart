import 'package:pull_to_refresh/pull_to_refresh.dart';
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
  late RefreshController refreshController;

  @override
  void initState() {
    super.initState();
    refreshController = RefreshController();
    SocketServices.instance.connectAndListen();
    FileSharing.initialise(ref);
    RecodamFirebaseService.initNotification(context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(nameProvider.notifier).state = LocalStorage.instance.getName();
      ref.read(profilePhotoProvider.notifier).state =
          LocalStorage.instance.getProfilePhoto();
    });
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
