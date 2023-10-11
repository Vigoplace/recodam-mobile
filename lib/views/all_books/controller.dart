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

  @override
  void initState() {
    super.initState();
    search = TextEditingController();
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
