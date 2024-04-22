import 'dart:async';
import 'package:recordam/utils/utils.dart';

class FileSharing {
  static late StreamSubscription intentDataStreamSubscription;

  static void initialise(WidgetRef ref) {
    // For sharing images coming from outside the app while the app is in the memory
    intentDataStreamSubscription = ReceiveSharingIntent.instance
        .getMediaStream()
        .listen((List<SharedMediaFile> value) {
      ref.read(shareIntentProvider.notifier).state = value;
      debugPrint('$value');
    }, onError: (err) {
      debugPrint("getIntentDataStream error: $err");
    });

    // For sharing images coming from outside the app while the app is closed
    ReceiveSharingIntent.instance.getInitialMedia().then(
        (List<SharedMediaFile> value) {
      debugPrint('$value');
      if (value.isNotEmpty) {
        ref.read(shareIntentProvider.notifier).state = value;
      }
    }, onError: (err) {
      debugPrint("getIntentDataStream error: $err");
    });
  }
}
