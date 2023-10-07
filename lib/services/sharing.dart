// import 'dart:async';

// import 'package:receive_sharing_intent/receive_sharing_intent.dart';
// import 'package:recordam/utils/utils.dart';

// class FileSharing {
//   static late StreamSubscription intentDataStreamSubscription;

//   static void initialise(BuildContext context) {
//     // For sharing images coming from outside the app while the app is in the memory
//     intentDataStreamSubscription = ReceiveSharingIntent.getMediaStream().listen(
//         (List<SharedMediaFile> value) {
//       debugPrint('$value');
//     }, onError: (err) {
//       debugPrint("getIntentDataStream error: $err");
//     });

//     // For sharing images coming from outside the app while the app is closed
//     ReceiveSharingIntent.getInitialMedia().then((List<SharedMediaFile> value) {
//       debugPrint('$value');
//     }, onError: (err) {
//       debugPrint("getIntentDataStream error: $err");
//     });
//   }
// }
