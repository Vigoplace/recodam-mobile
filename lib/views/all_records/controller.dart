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

  @override
  Widget build(BuildContext context) {
    return AllRecordsView(this);
  }
}
