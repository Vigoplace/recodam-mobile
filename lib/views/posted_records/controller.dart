import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:recordam/utils/utils.dart';
part 'view.dart';

class PostedRecordsScreen extends ConsumerStatefulWidget {
  static const path = "posted_records";
  static const name = "posted_records";
  const PostedRecordsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<PostedRecordsScreen> createState() => PostedRecordsController();
}

class PostedRecordsController extends ConsumerState<PostedRecordsScreen> {
  var pagination = Pagination();
  late RefreshController refreshController;

  late FutureProviderFamily<List<Record>, Pagination> booksProvider;

  @override
  void initState() {
    super.initState();
    booksProvider = FutureProvider.family(
      (ref, Pagination pagination) =>
          GetRequest.getRecords(pagination: pagination),
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
    return PostedRecordsView(this);
  }
}
