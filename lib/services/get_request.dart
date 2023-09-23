import 'package:recordam/utils/utils.dart';

class GetRequest {
  static NetworkService network = NetworkService();

  static Future<String> test() async {
    // var path = '';
    // var _ = await network.getRequestHandler(path);
    var _ = await Future.delayed(const Duration(seconds: 1), () => 'Hello');
    return _;
  }
}
