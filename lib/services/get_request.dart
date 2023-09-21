import 'package:dio/dio.dart';
import 'package:recordam/utils/utils.dart';

class GetRequest {
  static NetworkService network = NetworkService();

  static Future<void> deleteAjo({
    required int id,
    required CancelToken cancel,
  }) async {
    var path = 'recordam/delete/$id';
    var _ = await network.getRequestHandler(
      path,
      cancelToken: cancel,
    );
    return;
  }
}
