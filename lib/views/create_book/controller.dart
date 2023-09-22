import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:recordam/utils/utils.dart';
part 'view.dart';

class CreateBookScreen extends ConsumerStatefulWidget {
  static const path = "/create_book";
  static const name = "create_book";
  const CreateBookScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CreateBookScreen> createState() => CreateBookController();
}

class CreateBookController extends ConsumerState<CreateBookScreen> {
  var isLoading = ValueNotifier(false);
  ValueNotifier<File?> file = ValueNotifier(null);
  var access = ValueNotifier('public');

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
    return CreateBookView(this);
  }
}
