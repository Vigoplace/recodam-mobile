import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';
import 'package:recordam/utils/utils.dart';
part 'view.dart';
part 'view_id.dart';

class RecordScreen extends ConsumerStatefulWidget {
  static const path = "record";
  static const name = "record";
  final ViewRecordInfo info;
  const RecordScreen({
    super.key,
    required this.info,
  });

  @override
  ConsumerState<RecordScreen> createState() => RecordController();
}

class RecordController extends ConsumerState<RecordScreen> {
  var buttonState = ValueNotifier(ButtonState());
  late TextEditingController details;
  late TextEditingController book;
  int? bookId;
  ValueNotifier<UserData?> user = ValueNotifier(null);
  // late PdfController pdfController;

  void createRecord() {
    CreateRecord record = CreateRecord(
      senderName: widget.info.record.senderName,
      amount: widget.info.record.amount,
      details: widget.info.record.details,
      date: widget.info.record.date,
      file: widget.info.record.file,
      recordType: widget.info.record.recordType,
      id: widget.info.record.id,
      newBookId: bookId,
      receiverId: user.value?.id,
      bankName: widget.info.record.bankName,
      accountName: widget.info.record.accountName,
      accountNumber: widget.info.record.accountNumber,
      symbol: widget.info.record.symbol,
      editDetails: details.text,
    );
    late Future<String> Function({required CreateRecord record}) sendRequest;
    if ([
      DetailType.view,
    ].contains(widget.info.type)) {
      sendRequest = PostRequest.instance.updateRecord;
    } else if ([
      DetailType.create,
      DetailType.add,
    ].contains(widget.info.type)) {
      sendRequest = PostRequest.instance.createRecord;
    } else if ([
      DetailType.unconfirmed,
      DetailType.posted,
    ].contains(widget.info.type)) {
      sendRequest = PostRequest.instance.confirmRecord;
    }
    buttonState.value = ButtonState(
      isLoading: true,
      send: buttonState.value.send,
    );
    sendRequest(record: record).then((data) {
      buttonState.value = ButtonState(
        isLoading: false,
        send: buttonState.value.send,
      );
      ref.invalidate(homeRecordProvider);
      ref.invalidate(homeBookProvider);
      ShowFlushBar.showSuccess(
        message: data,
        perform: () {
          if ([
            DetailType.create,
          ].contains(widget.info.type)) {
            context.goNamed(HomeScreen.name);
          } else if ([
            DetailType.view,
          ].contains(widget.info.type)) {
            context.pop(record);
          } else if ([
            DetailType.add,
            DetailType.unconfirmed,
          ].contains(widget.info.type)) {
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
      listenError(error: error);
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
                15.verticalSpace,
                CustomTextInput(
                  controller: controller,
                  titleText: 'Search with phone number',
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
            bookId = null;
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
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  onPublicBookSelection();
                },
                child: Text(
                  'Send to another user',
                  style: TextStyle(
                    color: AppColor.red100,
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
            InkWell(
              overlayColor: MaterialStateColor.resolveWith(
                (states) => Colors.transparent,
              ),
              onTap: () {
                book.text = 'My Dashboard';
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
      if (widget.info.type == DetailType.view) {
        if (user.value == null) {
          buttonState.value = ButtonState(
            isLoading: buttonState.value.isLoading,
            send: true,
          );
          return;
        }
        if (details.text == widget.info.record.details) {
          buttonState.value = ButtonState(
            isLoading: buttonState.value.isLoading,
            send: false,
          );
        } else {
          buttonState.value = ButtonState(
            isLoading: buttonState.value.isLoading,
            send: true,
          );
          return;
        }
        if (book.text == widget.info.record.book?.bookName) {
          buttonState.value = ButtonState(
            isLoading: buttonState.value.isLoading,
            send: false,
          );
        } else {
          buttonState.value = ButtonState(
            isLoading: buttonState.value.isLoading,
            send: true,
          );
          return;
        }
      } else {
        buttonState.value = ButtonState(
          isLoading: buttonState.value.isLoading,
          send: true,
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    book = TextEditingController(text: widget.info.record.book?.bookName)
      ..addListener(() {
        confirmSend();
      });
    if (widget.info.record.file.endsWith('pdf')) {
      // pdfController = PdfController(
      //   document: PdfDocument.openFile(widget.info.record.file),
      // );
    }
    if (widget.info.type == DetailType.create) {
      book.text = 'My dashboard';
    } else if (widget.info.type == DetailType.view) {
      if (widget.info.record.book != null) {
        book.text = widget.info.record.book!.bookName;
      } else {
        book.text = 'My dashboard';
      }
    } else if (widget.info.type == DetailType.unconfirmed) {
      if (widget.info.record.book != null) {
        book.text = widget.info.record.book!.bookName;
      } else {
        book.text = 'My dashboard';
      }
    }
    details = TextEditingController(text: widget.info.record.details)
      ..addListener(() {
        confirmSend();
      });
    bookId = widget.info.record.book?.bookId;
    confirmSend();
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
