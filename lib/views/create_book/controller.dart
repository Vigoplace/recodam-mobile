import 'dart:io';
import 'package:recordam/utils/utils.dart';
part 'view.dart';

class CreateBookScreen extends ConsumerStatefulWidget {
  static const path = "create_book";
  static const name = "create_book";
  const CreateBookScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CreateBookScreen> createState() => CreateBookController();
}

class CreateBookController extends ConsumerState<CreateBookScreen> {
  var isLoading = ValueNotifier(false);
  ValueNotifier<File?> file = ValueNotifier(null);

  late TextEditingController bookName;
  late TextEditingController description;
  late TextEditingController balance;
  var recordType = RecordType.debit;
  var access = ValueNotifier(ManageAcess.public);
  bool submitted = false;
  var key = GlobalKey<FormState>();

  void createBook() async {
    submitted = true;
    setState(() {});
    if (key.currentState!.validate()) {
      CreateBook book = CreateBook(
        name: bookName.text,
        description: description.text,
        openingBalance: int.parse(balance.text),
        type: recordType.name,
        access: access.value.name,
      );
      final testProvider = FutureProvider.autoDispose(
          (ref) => PostRequest.createBook(book: book));

      ref.listenManual(
        testProvider,
        fireImmediately: true,
        (previous, next) {
          next.when(
            data: (data) {
              debugPrint('LOADED');
              isLoading.value = false;
              ref.invalidate(homeBookProvider);
              ShowFlushBar.showSuccess(
                context: context,
                message: data,
                perform: () {
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

  @override
  void initState() {
    super.initState();
    bookName = TextEditingController();
    description = TextEditingController();
    balance = TextEditingController();
  }

  @override
  void dispose() {
    bookName.dispose();
    description.dispose();
    balance.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CreateBookView(this);
  }
}
