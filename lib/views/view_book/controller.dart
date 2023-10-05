import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:recordam/utils/utils.dart';
part 'view.dart';

class ViewBookScreen extends ConsumerStatefulWidget {
  static const path = "view_book";
  static const name = "view_book";
  final Book book;
  const ViewBookScreen({
    Key? key,
    required this.book,
  }) : super(key: key);

  @override
  ConsumerState<ViewBookScreen> createState() => ViewBookController();
}

class ViewBookController extends ConsumerState<ViewBookScreen> {
  var pagination = Pagination();
  late RefreshController refreshController;

  late FutureProviderFamily<List<int>, Pagination> booksProvider;

  @override
  void initState() {
    super.initState();
    booksProvider = FutureProvider.family(
      (ref, Pagination pagination) =>
          GetRequest.testPagination(pagination: pagination),
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
    return ViewBookView(this);
  }
}
