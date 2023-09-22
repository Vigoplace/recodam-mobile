import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:recordam/utils/utils.dart';
part 'view.dart';

class CreateRecordScreen extends ConsumerStatefulWidget {
  static const path = "/create_record";
  static const name = "create_record";
  const CreateRecordScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CreateRecordScreen> createState() => CreateRecordController();
}

class CreateRecordController extends ConsumerState<CreateRecordScreen> {
  var isLoading = ValueNotifier(false);
  ValueNotifier<File?> file = ValueNotifier(null);

  void login() async {
    isLoading.value = true;
    ref.listenManual(
      loginProvider,
      fireImmediately: false,
      (previous, next) {
        next.when(
          data: (data) {
            debugPrint('LOADED');
            isLoading.value = false;
            // context.goNamed(HomeScreen.name);
          },
          error: (error, trace) {
            isLoading.value = false;
            debugPrint(error.toString());
          },
          loading: () => debugPrint('LOADING'),
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
