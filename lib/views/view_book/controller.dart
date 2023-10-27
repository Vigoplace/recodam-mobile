import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:recordam/utils/utils.dart';
import 'package:share_plus/share_plus.dart';
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
  late TextEditingController search;
  late RefreshController refreshController;

  @override
  void initState() {
    super.initState();
    pagination.book = widget.book.id;
    search = TextEditingController();
  }

  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewBookView(this);
  }
}
