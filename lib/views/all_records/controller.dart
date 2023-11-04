import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:recordam/utils/utils.dart';
part 'view.dart';

class AllRecordsScreen extends ConsumerStatefulWidget {
  static const path = "all_records";
  static const name = "all_records";
  const AllRecordsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AllRecordsScreen> createState() => AllRecordsController();
}

class AllRecordsController extends ConsumerState<AllRecordsScreen> {
  var pagination = Pagination(limit: 10);
  late TextEditingController search;
  late FutureProvider<Map<DateTime, List<Record>>> allRecords;
  late RefreshController refreshController;

  final Map<DateTime, List<Record>> holder = {};

  @override
  void initState() {
    super.initState();
    search = TextEditingController();
    allRecords = FutureProvider((ref) => GetRequest.instance.getGroupedRecords(
          pagination: pagination,
        ));
    refreshController = RefreshController();
  }

  void reload() => setState(() {});

  @override
  void dispose() {
    search.dispose();
    refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AllRecordsView(this);
  }
}
