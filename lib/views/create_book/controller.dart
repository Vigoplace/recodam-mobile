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

  void createBook() async {
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
              message: 'Successfully created book',
              perform: () {
                ref.invalidate(homeBookProvider);
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
    return CreateBookView(this);
  }
}
