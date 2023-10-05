import 'package:recordam/utils/utils.dart';

class PatchRequest {
  static NetworkService network = NetworkService();

  static Future<void> deleteAjo({
    required int id,
    required CancelToken cancel,
  }) async {
    var path = 'recordam/delete/$id';
    var _ = await network.patchRequestHandler(
      path,
      cancelToken: cancel,
    );
    return;
  }
}
