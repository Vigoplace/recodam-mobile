import 'package:grouped_list/grouped_list.dart';
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
  var pagination = Pagination();
  late TextEditingController search;
  late FutureProvider<Map<DateTime, List<Record>>> allRecords;

  @override
  void initState() {
    super.initState();
    search = TextEditingController();
    allRecords = FutureProvider((ref) => GetRequest.getGroupedRecords());
  }

  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AllRecordsView(this);
  }
}
