import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:recordam/utils/utils.dart';
part 'view.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const path = "/home";
  static const name = "home";
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => HomeController();
}

class HomeController extends ConsumerState<HomeScreen> {
  var acceptedTerms = ValueNotifier(false);
  var showPin = ValueNotifier(false);
  late RefreshController refreshController;
  late RefreshController homeRefresh;

  @override
  void initState() {
    super.initState();
    refreshController = RefreshController();
    homeRefresh = RefreshController();
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
    homeRefresh.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    homeRefresh = RefreshController();
    return HomeView(this);
  }
}
