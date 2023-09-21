import 'package:recordam/utils/utils.dart';

class PostRequest {
  static NetworkService network = NetworkService();

  static Future<void> login() async {
    // var path = 'recordam/login';
    // var _ = await network.postRequestHandler(path);
    await Future.delayed(const Duration(seconds: 1));
    return;
  }
}
