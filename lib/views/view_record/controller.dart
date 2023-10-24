import 'package:recordam/utils/utils.dart';
part 'view.dart';

class RecordScreen extends ConsumerStatefulWidget {
  static const path = "record";
  static const name = "record";
  final Record record;
  const RecordScreen({
    Key? key,
    required this.record,
  }) : super(key: key);

  @override
  ConsumerState<RecordScreen> createState() => RecordController();
}

class RecordController extends ConsumerState<RecordScreen> {
  var isLoading = ValueNotifier(false);
  late TextEditingController details;
  late TextEditingController book;
  int? bookId;

  void createRecord() {
    CreateRecord record = CreateRecord(
      senderName: widget.record.senderName,
      amount: widget.record.amount,
      details: details.text.isEmpty ? widget.record.details : details.text,
      date: widget.record.date,
      file: widget.record.file,
      recordType: widget.record.recordType,
      id: widget.record.id,
      newBookId: bookId,
      bankName: widget.record.bankName,
      accountName: widget.record.accountName,
      accountNumber: widget.record.accountNumber,
      symbol: widget.record.symbol,
    );
    late Future<String> testFuture;

    if (widget.record.isDatabase) {
      testFuture = PostRequest.updateRecord(record: record);
    } else {
      testFuture = PostRequest.createRecord(record: record);
    }
    testFuture.then((data) {
      debugPrint('LOADED');
      isLoading.value = false;
      ref.invalidate(homeRecordProvider);
      ref.invalidate(homeBookProvider);
      ShowFlushBar.showSuccess(
        context: context,
        message: data,
        perform: () => context.goNamed(HomeScreen.name),
      );
    }).catchError((error) {
      isLoading.value = false;
      debugPrint(error.toString());
      listenError(
        error: error,
        context: context,
      );
    });
  }

  void showBooks() async {
    showModalBottomSheet<ManageAcess?>(
      showDragHandle: true,
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
      ),
      backgroundColor: AppColor.grey,
      builder: (context) => Container(
        color: AppColor.grey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Choose the type of book",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: AppColor.grey100,
              ),
            ),
            30.verticalSpace,
            ListTile(
              title: const Text('Private book'),
              titleTextStyle: TextStyle(
                color: AppColor.grey100,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
              onTap: () => context.pop(ManageAcess.private),
              trailing: const SvgButton(
                icon: AppSvg.chevronRight,
              ),
            ).animate().moveX(),
            10.verticalSpace,
            ListTile(
              title: const Text('Public book'),
              titleTextStyle: TextStyle(
                color: AppColor.grey100,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
              onTap: () => context.pop(ManageAcess.public),
              trailing: const SvgButton(
                icon: AppSvg.chevronRight,
              ),
            ).animate().moveX(),
            50.verticalSpace,
          ],
        ),
      ),
    ).then((choice) async {
      if (choice != null) {
        if (choice == ManageAcess.private) {
          var bookChoice = await context.pushNamed<Book?>(
            AddToBookScreen.name,
            extra: AddToBookInfo(
              title: choice,
            ),
          );
          if (bookChoice != null) {
            book.text = bookChoice.name;
            bookId = bookChoice.id;
          }
        } else {
          onPublicBookSelection();
        }
      }
    });
  }

  void onPublicBookSelection() async {
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
      backgroundColor: AppColor.grey,
      builder: (context) => Container(
        color: AppColor.grey,
        child: Padding(
          padding: [20].pad,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Post to Public book",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColor.grey100,
                ),
              ),
              30.verticalSpace,
              const CustomTextInput(
                titleText: 'Enter the owner’s number',
              ),
              40.verticalSpace,
              Row(
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
              50.verticalSpace,
            ],
          ),
        ),
      ),
    ).then((choice) async {
      if (choice != null) {
        var bookChoice = await context.pushNamed<Book?>(
          AddToBookScreen.name,
          extra: AddToBookInfo(
            title: ManageAcess.public,
          ),
        );
        if (bookChoice != null) {
          book.text = bookChoice.name;
          bookId = bookChoice.id;
        }
      }
    });
  }

  // void showBooks() async {
  //   var pagination = Pagination();
  //   var search = TextEditingController();
  //   var choice = await showModalBottomSheet<Book?>(
  //     showDragHandle: true,
  //     isScrollControlled: true,
  //     context: context,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.only(
  //         topLeft: Radius.circular(30.r),
  //         topRight: Radius.circular(30.r),
  //       ),
  //     ),
  //     backgroundColor: AppColor.grey,
  //     builder: (context) => Container(
  //       color: AppColor.grey,
  //       height: MediaQuery.sizeOf(context).height * 0.7,
  //       child: Column(
  //         children: [
  //           Padding(
  //             padding: [16, 0].pad,
  //             child: CustomTextInput(
  //               controller: search,
  //               prefix: const SvgButton(
  //                 icon: AppSvg.blackSearch,
  //               ),
  //               hintText: 'Search',
  //             ),
  //           ),
  //           Expanded(
  //             child: Books(
  //               pagination: pagination,
  //               mini: true,
  //               searchWord: search,
  //               onTap: (p0) {
  //                 context.pop(p0);
  //               },
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  //   if (choice != null) {
  //     book.text = choice.name;
  //     bookId = choice.id;
  //   }
  // }

  @override
  void initState() {
    super.initState();
    book = TextEditingController(text: widget.record.book?.bookName);
    details = TextEditingController(text: widget.record.details);
    bookId = widget.record.book?.bookId;
  }

  @override
  void dispose() {
    book.dispose();
    details.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RecordView(this);
  }
}
