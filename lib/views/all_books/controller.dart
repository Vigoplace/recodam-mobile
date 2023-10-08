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

  @override
  Widget build(BuildContext context) {
    return AllBooksView(this);
  }
}
