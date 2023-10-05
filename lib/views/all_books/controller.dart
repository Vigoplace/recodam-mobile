import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:recordam/utils/utils.dart';
part 'view.dart';

class AllBooksScreen extends ConsumerStatefulWidget {
  static const path = "all_books";
  static const name = "all_books";
  const AllBooksScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AllBooksScreen> createState() => AllBooksController();
}

class AllBooksController extends ConsumerState<AllBooksScreen> {
  var pagination = Pagination();
  late RefreshController refreshController;

  late FutureProviderFamily<List<Book>, Pagination> booksProvider;

  @override
  void initState() {
    super.initState();
    booksProvider = FutureProvider.family(
      (ref, Pagination pagination) =>
          GetRequest.getAllBooks(pagination: pagination),
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
    return AllBooksView(this);
  }
}
