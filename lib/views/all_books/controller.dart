import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:recordam/utils/utils.dart';
part 'view.dart';

class AllBooksScreen extends ConsumerStatefulWidget {
  static const path = "all_books";
  static const name = "all_books";
  const AllBooksScreen({super.key});

  @override
  ConsumerState<AllBooksScreen> createState() => AllBooksController();
}

class AllBooksController extends ConsumerState<AllBooksScreen> {
  var pagination = Pagination(limit: 10);
  late TextEditingController search;
  late RefreshController refreshController;

  final Map<DateTime, List<Book>> holder = {};

  @override
  void initState() {
    super.initState();
    search = TextEditingController();
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
    return AllBooksView(this);
  }
}
