import 'dart:async';
import 'package:recordam/utils/utils.dart';

class FileSharing {
  static late StreamSubscription intentDataStreamSubscription;

  static void initialise(WidgetRef ref) {
    // For sharing images coming from outside the app while the app is in the memory
    intentDataStreamSubscription = FlutterSharingIntent.instance.getMediaStream().listen(
        (List<SharedFile> value) {
      ref.read(shareIntentProvider.notifier).state = value;
      debugPrint('$value');
    }, onError: (err) {
      debugPrint("getIntentDataStream error: $err");
    });

    // For sharing images coming from outside the app while the app is closed
    FlutterSharingIntent.instance.getInitialSharing().then((List<SharedFile> value) {
      debugPrint('$value');
      if (value.isNotEmpty) {
        ref.read(shareIntentProvider.notifier).state = value;
      }
    }, onError: (err) {
      debugPrint("getIntentDataStream error: $err");
    });
  }
}
