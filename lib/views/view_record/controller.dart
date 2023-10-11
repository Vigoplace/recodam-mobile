
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
      backgroundColor: AppColor.grey,
      builder: (context) => Container(
        color: AppColor.grey,
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
            Expanded(
              child: Books(
                pagination: pagination,
                mini: true,
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
