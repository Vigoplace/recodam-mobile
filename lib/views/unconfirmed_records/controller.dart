import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:recordam/utils/utils.dart';
part 'view.dart';

class UnConfirmedRecordsScreen extends ConsumerStatefulWidget {
  static const path = "confirmed_records";
  static const name = "confirmed_records";
  const UnConfirmedRecordsScreen({super.key});

  @override
  ConsumerState<UnConfirmedRecordsScreen> createState() =>
      UnConfirmedRecordsController();
}

class UnConfirmedRecordsController
    extends ConsumerState<UnConfirmedRecordsScreen> {
  var pagination = Pagination();
  late RefreshController refreshController;

  late FutureProviderFamily<List<Record>, Pagination> booksProvider;

  @override
  void initState() {
    super.initState();
    booksProvider = FutureProvider.family(
      (ref, Pagination pagination) =>
          GetRequest.instance.getRecords(pagination: pagination),
    );
    refreshController = RefreshController();
  }

  void reload() => setState(() {});

  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UnConfirmedRecordsView(this);
  }
}
