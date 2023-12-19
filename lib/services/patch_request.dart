import 'package:recordam/utils/utils.dart';

class PatchRequest extends NetworkService {
  static final PatchRequest instance = PatchRequest._init();
  PatchRequest._init();
  Future<void> markAsRead({
    required int id,
  }) async {
    var path = 'notification/$id';
    var _ = await patchRequestHandler(path);
    return;
  }
}
