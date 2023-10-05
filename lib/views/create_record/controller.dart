import 'dart:io';
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

  void createRecord() async {
    final testProvider = FutureProvider.autoDispose((ref) => GetRequest.test());
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

  void pickImage() async {
    final ImagePicker picker = ImagePicker();
    var xFile = await picker.pickImage(source: ImageSource.gallery);
    if (xFile != null) {
      file.value = File(xFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CreateRecordView(this);
  }
}
