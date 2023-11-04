import 'package:recordam/utils/utils.dart';
part 'view.dart';

class RecordScreen extends ConsumerStatefulWidget {
  static const path = "record";
  static const name = "record";
  final ViewRecordInfo info;
  const RecordScreen({
    Key? key,
    required this.info,
  }) : super(key: key);

  @override
  ConsumerState<RecordScreen> createState() => RecordController();
}

class RecordController extends ConsumerState<RecordScreen> {
  var buttonState = ValueNotifier(ButtonState());
  late TextEditingController details;
  late TextEditingController book;
  int? bookId;
  ValueNotifier<bool> isPost = ValueNotifier(false);
  ValueNotifier<UserData?> user = ValueNotifier(null);

  void createRecord() {
    CreateRecord record = CreateRecord(
      senderName: widget.info.record.senderName,
      amount: widget.info.record.amount,
      details: details.text.isEmpty ? widget.info.record.details : details.text,
      date: widget.info.record.date,
      file: widget.info.record.file,
      recordType: widget.info.record.recordType,
      id: widget.info.record.id,
      newBookId: bookId,
      newOwnerId: user.value?.id,
      bankName: widget.info.record.bankName,
      accountName: widget.info.record.accountName,
      accountNumber: widget.info.record.accountNumber,
      symbol: widget.info.record.symbol,
    );
    late Future<String> Function({required CreateRecord record}) sendRequest;
    if (widget.info.record.isDatabase) {
      sendRequest = PostRequest.instance.updateRecord;
    } else {
      sendRequest = PostRequest.instance.createRecord;
    }
    sendRequest(record: record).then((data) {
      buttonState.value = ButtonState(
        isLoading: false,
        send: buttonState.value.send,
      );
      ref.invalidate(homeRecordProvider);
      ref.invalidate(homeBookProvider);
      ShowFlushBar.showSuccess(
        context: context,
        message: data,
        perform: () {
          if ([DetailType.create].contains(widget.info.type)) {
            context.goNamed(HomeScreen.name);
          } else if ([DetailType.view].contains(widget.info.type)) {
            context.pop(record);
          } else if ([DetailType.add].contains(widget.info.type)) {
            context.pop(record);
            context.pop(record);
          }
        },
      );
    }).catchError((error) {
      buttonState.value = ButtonState(
        isLoading: false,
        send: buttonState.value.send,
      );
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
              number: '',
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
    String number = '';
    TextEditingController controller = TextEditingController();
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
      builder: (context) => StatefulBuilder(builder: (context, refresh) {
        return Container(
          color: AppColor.grey,
          height: MediaQuery.sizeOf(context).height * 0.6,
          child: Padding(
            padding: [20].pad,
            child: Column(
              // mainAxisSize: MainAxisSize.min,
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
                CustomTextInput(
                  controller: controller,
                  titleText: 'Enter the owner’s number',
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.done,
                  onChanged: (p0) => refresh(() => number = p0),
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
                      onTap: controller.text.isEmpty
                          ? null
                          : () => context.pop(true),
                      child: Text(
                        "Okay",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: controller.text.isEmpty
                              ? AppColor.grey20
                              : AppColor.light100,
                        ),
                      ),
                    ),
                  ],
                ).animate().moveX(),
                50.verticalSpace,
              ],
            ),
          ),
        );
      }),
    ).then((choice) async {
      if (choice != null) {
        var bookChoice = await context.pushNamed<PostBookInfo?>(
          AddToBookScreen.name,
          extra: AddToBookInfo(
            title: ManageAcess.public,
            number: number,
          ),
        );

        if (bookChoice != null) {
          if (bookChoice.book == null) {
            user.value = bookChoice.user;
            isPost.value = true;
            bookId = null;
            book.clear();
          } else {
            user.value = bookChoice.user;
            book.text = (bookChoice.book!).name;
            bookId = (bookChoice.book!).id;
          }
        }
      }
    });
  }

  void chooseBook() async {
    var pagination = Pagination();
    var search = TextEditingController();
    var choice = await showModalBottomSheet<Book?>(
      showDragHandle: true,
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
      ),
      backgroundColor: AppColor.white,
      builder: (context) => SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.7,
        child: Column(
          children: [
            Padding(
              padding: [16, 0].pad,
              child: CustomTextInput(
                controller: search,
                prefix: const SvgButton(
                  icon: AppSvg.blackSearch,
                ),
                hintText: 'Search',
              ),
            ),
            20.verticalSpace,
            InkWell(
              overlayColor: MaterialStateColor.resolveWith(
                (states) => Colors.transparent,
              ),
              onTap: () {
                book.text = 'Dashboard';
                bookId = null;
                context.pop();
              },
              child: Container(
                padding: [16, 16].pad,
                margin: [16].pad,
                decoration: ShapeDecoration(
                  color: AppColor.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppSvg.dashboard,
                    ).animate().scale(),
                    20.horizontalSpace,
                    Text(
                      'My dasboard',
                      style: TextStyle(
                        color: AppColor.grey100,
                        fontWeight: FontWeight.w700,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            15.verticalSpace,
            Expanded(
              child: Books(
                pagination: pagination,
                space: 2,
                mini: true,
                topMargin: 0,
                searchWord: search,
                onTap: (p0) {
                  context.pop(p0);
                },
              ),
            ),
          ],
        ),
      ),
    );
    if (choice != null) {
      book.text = choice.name;
      bookId = choice.id;
    }
  }

  void confirmSend() {
    if (book.text.isEmpty) {
      buttonState.value = ButtonState(
        isLoading: buttonState.value.isLoading,
        send: false,
      );
    } else {
      buttonState.value = ButtonState(
        isLoading: buttonState.value.isLoading,
        send: true,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    book = TextEditingController(text: widget.info.record.book?.bookName)
      ..addListener(() {
        confirmSend();
      });
    details = TextEditingController(text: widget.info.record.details);
    bookId = widget.info.record.book?.bookId;
  }

  @override
  void dispose() {
    book.dispose();
    details.dispose();
    buttonState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RecordView(this);
  }
}
