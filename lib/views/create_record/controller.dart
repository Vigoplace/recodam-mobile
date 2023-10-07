import 'dart:io';
import 'package:intl/intl.dart';
import 'package:recordam/utils/utils.dart';
part 'view.dart';

class CreateRecordScreen extends ConsumerStatefulWidget {
  static const path = "create_record";
  static const name = "create_record";
  const CreateRecordScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CreateRecordScreen> createState() => CreateRecordController();
}

class CreateRecordController extends ConsumerState<CreateRecordScreen> {
  var isLoading = ValueNotifier(false);
  ValueNotifier<File?> file = ValueNotifier(null);
  late TextEditingController senderName;
  late TextEditingController amount;
  late TextEditingController bankName;
  late TextEditingController accountNumber;
  late TextEditingController accountName;
  late TextEditingController details;
  late TextEditingController date;
  RecordType recordType = RecordType.debit;

  bool submitted = false;
  var key = GlobalKey<FormState>();

  void createRecord() async {
    submitted = true;
    setState(() {});
    if (key.currentState!.validate()) {
      final testProvider =
          FutureProvider.autoDispose((ref) => GetRequest.test());
      ref.listenManual(
        testProvider,
        fireImmediately: true,
        (previous, next) {
          next.when(
            data: (data) {
              debugPrint('LOADED');
              isLoading.value = false;
              ShowFlushBar.showSuccess(
                context: context,
                message: 'Successfully created record',
                perform: () {
                  ref.invalidate(homeRecordProvider);
                  context.pop();
                },
              );
            },
            error: (error, trace) {
              isLoading.value = false;
              debugPrint(error.toString());
              errorFuntions(
                error,
                trace,
                context: context,
              );
            },
            loading: () => isLoading.value = true,
          );
        },
      );
    }
  }

  void pickImage() async {
    final ImagePicker picker = ImagePicker();
    var xFile = await picker.pickImage(source: ImageSource.gallery);
    if (xFile != null) {
      file.value = File(xFile.path);
    }
  }

  void selectDate() async {
    var choiceDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      initialDate: DateTime.now(),
      lastDate: DateTime(2050),
    );
    if (choiceDate != null) {
      date.text = DateFormat('EEE-dd-MMM-yyyy').format(choiceDate);
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
