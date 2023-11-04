import 'package:recordam/utils/utils.dart';

class PatchRequest extends NetworkService {
  static final PatchRequest instance = PatchRequest._init();
  PatchRequest._init();
  Future<void> deleteAjo({
    required int id,
    required CancelToken cancel,
  }) async {
    var path = 'recordam/delete/$id';
    var _ = await patchRequestHandler(
      path,
      cancelToken: cancel,
    );
    return;
  }
}
