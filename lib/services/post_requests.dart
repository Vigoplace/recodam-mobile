import 'package:recordam/utils/utils.dart';

class PostRequest {
  static NetworkService network = NetworkService();

  static Future<void> test() async {
    // var path = '';
    // var _ = await network.getRequestHandler(path);
    await Future.delayed(const Duration(seconds: 2));
    return;
  }
}
