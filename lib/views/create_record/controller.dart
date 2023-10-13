import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:recordam/utils/utils.dart';
part 'view.dart';

class CreateRecordScreen extends ConsumerStatefulWidget {
  static const path = "create_record";
  static const name = "create_record";

  final Create create;
  const CreateRecordScreen({
    Key? key,
    required this.create,
  }) : super(key: key);

  @override
  ConsumerState<CreateRecordScreen> createState() => CreateRecordController();
}

class CreateRecordController extends ConsumerState<CreateRecordScreen> {
  ValueNotifier<File?> file = ValueNotifier(null);
  late TextEditingController senderName;
  late TextEditingController amount;
  late TextEditingController bankName;
  late TextEditingController accountNumber;
  late TextEditingController accountName;
  late TextEditingController details;
  late TextEditingController date;
  RecordType recordType = RecordType.debit;
  var currency = ValueNotifier(CurrencyModel(
    symbol: '₦',
    short: 'NGN',
    name: 'Naira',
  ));
  BankModel? bank;

  bool submitted = false;
  var formKey = GlobalKey<FormState>();
  late DateTime dateTime;

  void createRecord() async {
    if (file.value == null) {
      ShowFlushBar.showError('Select a payment proof', context: context);
      return;
    }
    setState(() => submitted = true);
    if (formKey.currentState!.validate()) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => RecordScreen(
            record: Record(
              id: 0,
              date: dateTime,
              symbol: currency.value.symbol,
              senderName: senderName.text,
              amount: amount.text,
              bankName: bankName.text.isEmpty ? null : bankName.text,
              accountNumber:
                  accountNumber.text.isEmpty ? null : accountNumber.text,
              accountName: accountName.text.isEmpty ? null : accountName.text,
              details: details.text,
              recordType: recordType.name,
              file: file.value!.path,
              ownerId: 0,
              isDatabase: false,
              book: widget.create.bookId != null
                  ? RecordBook(
                      bookId: widget.create.bookId!.id!,
                      bookName: widget.create.bookId!.name,
                    )
                  : null,
            ),
          ),
        ),
      );
    } else {
      ShowFlushBar.showError(
        'One or more required field is missing',
        context: context,
      );
    }
  }

  void pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowedExtensions: ['pdf', 'png', 'jpeg', 'jpg'],
      type: FileType.custom,
    );

    if (result != null) {
      file.value = File(result.files.single.path!);
    }
  }

  void selectDate() async {
    var choiceDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      initialDate: DateTime.now(),
      lastDate: DateTime.now(),
    );
    if (choiceDate != null) {
      dateTime = choiceDate;
      date.text = DateFormat('EEE-dd-MMM-yyyy').format(choiceDate);
    }
  }

  Future showCurrencyList() async {
    var choice = await showModalBottomSheet<CurrencyModel?>(
      context: context,
      showDragHandle: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
      ),
      isScrollControlled: true,
      builder: (context) {
        return Consumer(
          builder: (context, ref, _) {
            var country = ref.watch(currencyProvider);
            return country.when(
              data: (data) {
                return SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.4,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: [0, 0, 20, 0].pad,
                          child: SvgButton(
                            icon: AppSvg.remove,
                            onTap: () => context.pop(),
                          ),
                        ),
                      ),
                      Expanded(
                        child: data.isNotEmpty
                            ? ListView.builder(
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  var country = data[index];
                                  return ListTile(
                                    onTap: () => context.pop(country),
                                    title: Text(country.name),
                                  ).animate().scale();
                                },
                              )
                            : const EmptyWidget(
                                text: 'No such currency',
                              ),
                      ),
                    ],
                  ),
                );
              },
              error: (error, trace) {
                error as DioException;
                return SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.5,
                  child: ErrorScreen(
                    error: error,
                    reload: () => ref.invalidate(currencyProvider),
                  ),
                );
              },
              loading: () => SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.5,
                child: const CustomLoader(),
              ),
            );
          },
        );
      },
    );
    if (choice != null) {
      currency.value = choice;
    }
  }

  Future showBankList() async {
    ValueNotifier<List<BankModel>> banks = ValueNotifier([]);
    bool loaded = false;
    var choice = await showModalBottomSheet<BankModel?>(
      context: context,
      showDragHandle: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
      ),
      isScrollControlled: true,
      builder: (context) {
        return Consumer(
          builder: (context, ref, _) {
            var country = ref.watch(bankProvider);
            return country.when(
              data: (data) {
                if (!loaded) {
                  banks.value = data.toList();
                }
                loaded = true;
                return SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.7,
                  child: Column(
                    children: [
                      Padding(
                        padding: [20, 0].pad,
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomTextInput(
                                hintText: 'Search for bank',
                                onChanged: (p0) {
                                  banks.value = data
                                      .where((element) => element.name
                                          .toLowerCase()
                                          .contains(p0.toLowerCase()))
                                      .toList();
                                },
                              ),
                            ),
                            10.horizontalSpace,
                            SvgButton(
                              icon: AppSvg.remove,
                              onTap: () => context.pop(),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: ValueListenableBuilder(
                          valueListenable: banks,
                          builder: (context, value, _) {
                            return value.isNotEmpty
                                ? ListView.builder(
                                    itemCount: value.length,
                                    itemBuilder: (context, index) {
                                      var country = value[index];
                                      return ListTile(
                                        onTap: () => context.pop(country),
                                        title: Text(country.name),
                                      ).animate().scale();
                                    },
                                  )
                                : const EmptyWidget(
                                    text: 'No such currency',
                                  );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
              error: (error, trace) {
                error as DioException;
                return SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.5,
                  child: ErrorScreen(
                    error: error,
                    reload: () => ref.invalidate(bankProvider),
                  ),
                );
              },
              loading: () => SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.5,
                child: const CustomLoader(),
              ),
            );
          },
        );
      },
    );
    if (choice != null) {
      bankName.text = choice.name;
    }
  }

  @override
  void initState() {
    super.initState();
    senderName = TextEditingController();
    amount = TextEditingController();
    bankName = TextEditingController();
    accountNumber = TextEditingController();
    accountName = TextEditingController();
    details = TextEditingController();
    date = TextEditingController();
    if (widget.create.media.isNotEmpty) {
      file.value = File(widget.create.media.first.path);
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(shareIntentProvider.notifier).state.clear();
    });
  }

  @override
  void dispose() {
    senderName.dispose();
    amount.dispose();
    bankName.dispose();
    accountNumber.dispose();
    accountName.dispose();
    details.dispose();
    date.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CreateRecordView(this);
  }
}
