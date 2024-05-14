import 'dart:async';
import 'package:recordam/utils/utils.dart';

class FileSharing {
  static final FileSharing instance = FileSharing._init();
  FileSharing._init();

  StreamSubscription? intentDataStreamSubscription;

  void initialise(WidgetRef ref) {
    // For sharing images coming from outside the app while the app is in the memory
    intentDataStreamSubscription = ReceiveSharingIntent.instance
        .getMediaStream()
        .listen((List<SharedMediaFile> value) {
      ref.read(shareIntentProvider.notifier).state = value;
    }, onError: (err) {
      debugPrint("getIntentDataStream error: $err");
    });

    // For sharing images coming from outside the app while the app is closed
    ReceiveSharingIntent.instance.getInitialMedia().then(
        (List<SharedMediaFile> value) {
      debugPrint('Camcv closed ${value.map((e) => e.toMap())}');
      if (value.isNotEmpty) {
        ref.read(shareIntentProvider.notifier).state = value;
        ReceiveSharingIntent.instance.reset();
      }
    }, onError: (err) {
      debugPrint("getIntentDataStream error: $err");
    });
  }

  void dispose() {
    intentDataStreamSubscription?.cancel();
  }
}
