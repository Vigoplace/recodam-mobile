import 'package:recordam/utils/utils.dart';
part 'view.dart';

class AddToBookScreen extends ConsumerStatefulWidget {
  static const path = "add_to_book";
  static const name = "add_to_book";
  final AddToBookInfo bookInfo;
  const AddToBookScreen({
    Key? key,
    required this.bookInfo,
  }) : super(key: key);

  @override
  ConsumerState<AddToBookScreen> createState() => AddToBookController();
}

class AddToBookController extends ConsumerState<AddToBookScreen> {
  var pagination = Pagination();
  late TextEditingController search;

  @override
  void initState() {
    super.initState();
    search = TextEditingController();
  }

  void showConfirmation(Book book) {
    showModalBottomSheet<bool?>(
      showDragHandle: true,
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
      ),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: [20].pad,
                child: Text(
                  "Post to",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            22.verticalSpace,
            BookCardMini(
              book: book,
            ),
            Padding(
              padding: [20].pad,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColor.grey20,
                      ),
                    ),
                  ),
                  40.horizontalSpace,
                  GestureDetector(
                    onTap: () => context.pop(true),
                    child: Text(
                      "Okay",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColor.light100,
                      ),
                    ),
                  ),
                ],
              ).animate().moveX(),
            ),
            50.verticalSpace,
          ],
        );
      },
    ).then((choice) {
      if (choice == true) {
        context.pop(book);
      }
    });
  }

  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AddToBookView(this);
  }
}
