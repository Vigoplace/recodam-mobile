import 'package:recordam/utils/utils.dart';
part 'view.dart';

class AddToBookScreen extends ConsumerStatefulWidget {
  static const path = "add_to_book";
  static const name = "add_to_book";
  final AddToBookInfo bookInfo;
  const AddToBookScreen({
    super.key,
    required this.bookInfo,
  });

  @override
  ConsumerState<AddToBookScreen> createState() => AddToBookController();
}

class AddToBookController extends ConsumerState<AddToBookScreen> {
  var pagination = Pagination();
  late TextEditingController search;

  late FutureProvider<UserData> info;

  @override
  void initState() {
    super.initState();
    search = TextEditingController();
    info = FutureProvider(
      (ref) => GetRequest.instance.getUserNumber(
        number: widget.bookInfo.number,
        pagination: pagination,
      ),
    );
  }

  void showConfirmation(Book? book) {
    showModalBottomSheet<bool?>(
      showDragHandle: true,
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      backgroundColor: AppColor.white,
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
                    fontSize: 16.spMin,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            if (book != null) ...[
              22.verticalSpacing,
              BookCardMini(
                book: book,
                onTap: (p0) {},
              )
            ] else ...[
              10.verticalSpacing,
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: [20].pad,
                  child: Text(
                    '${ref.read(info).asData!.value.name}\'s Dashboard',
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              )
            ],
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
                        fontSize: 16.spMin,
                        fontWeight: FontWeight.w700,
                        color: AppColor.grey20,
                      ),
                    ),
                  ),
                  40.horizontalSpacing,
                  GestureDetector(
                    onTap: () => context.pop(true),
                    child: Text(
                      "Okay",
                      style: TextStyle(
                        fontSize: 16.spMin,
                        fontWeight: FontWeight.w700,
                        color: AppColor.light100,
                      ),
                    ),
                  ),
                ],
              ).animate().moveX(),
            ),
            50.verticalSpacing,
          ],
        );
      },
    ).then(
      (choice) {
        if (choice == true) {
          if (!mounted) return;
          context.pop(
            PostBookInfo(
              book: book,
              user: ref.read(info).value!,
            ),
          );
        }
      },
    );
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
