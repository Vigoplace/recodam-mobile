import 'package:grouped_list/grouped_list.dart';
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
  late TextEditingController search;
  late FutureProvider<Map<DateTime, List<Book>>> allBooks;

  @override
  void initState() {
    super.initState();
    search = TextEditingController();
    allBooks = FutureProvider((ref) => GetRequest.getGroupedBooks());
  }

  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AllBooksView(this);
  }
}
