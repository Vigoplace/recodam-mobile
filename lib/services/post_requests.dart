import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';
import 'package:recordam/utils/utils.dart';

class PostRequest extends NetworkService {
  static final PostRequest instance = PostRequest._init();
  PostRequest._init();

  Future<UserModel> createAccount({
    required CreateAccountModel createAccountModel,
    required CancelToken cancelToken,
  }) async {
    var path = 'auth/create';
    var payload = createAccountModel.toJson();
    var messagingToken = await FirebaseMessaging.instance.getToken();
    payload.addAll({'messaging_token': messagingToken});
    var user =
        await postRequestHandler(path, data: payload, cancelToken: cancelToken);
    return UserModel.fromJson(user.data);
  }

  Future<UserModel> loginToAccount({
    required LoginModel loginModel,
    required CancelToken cancelToken,
  }) async {
    var path = 'auth/login';
    var payload = loginModel.toJson();
    var messagingToken = await FirebaseMessaging.instance.getToken();
    payload.addAll({'messaging_token': messagingToken});
    var user = await postRequestHandler(
      path,
      data: payload,
      cancelToken: cancelToken,
    );
    UserModel userModel = UserModel.fromJson(user.data);
    await LocalStorage.instance.saveUserInfo(userModel.data);
    return userModel;
  }

  Future<String> updatePin({
    required String oldPassword,
    required String newPassword,
    required CancelToken cancelToken,
  }) async {
    var path = 'auth/update-pin';
    var user = await postRequestHandler(
      path,
      data: {
        "new_password": newPassword,
        "old_password": oldPassword,
      },
      cancelToken: cancelToken,
    );
    return user.data['message'];
  }

  Future<String> forgotPassword({
    required String email,
    required CancelToken cancelToken,
  }) async {
    var path = 'auth/forgot-password';
    var user = await postRequestHandler(
      path,
      data: {'email': email},
      cancelToken: cancelToken,
    );
    return user.data['message'];
  }

  Future<String> resetPassword({
    required String otp,
    required String pin,
  }) async {
    var path = 'auth/reset-password';
    var email = LocalStorage.instance.getEmail();
    var user = await postRequestHandler(
      path,
      data: {
        'email': email,
        'otp': otp,
        'new_password': pin,
        'confirm_password': pin,
      },
    );
    return user.data['message'];
  }

  Future<String> createBook({
    required CreateBook book,
  }) async {
    var path = 'book/create';
    var user = await postRequestHandler(
      path,
      data: book.toJson(),
    );
    return user.data['message'];
  }

  Future<String> createRecord({
    required CreateRecord record,
  }) async {
    var path = 'record/create';
    FormData data = FormData();
    String mimeType = mime(record.file)!;
    String type = mimeType.split('/')[0];
    String subtype = mimeType.split('/')[1];

    data.fields.addAll([
      MapEntry('sender_name', record.senderName),
      MapEntry('amount', record.amount.toString()),
      MapEntry('bank_name', record.bankName ?? ''),
      MapEntry('account_number', record.accountNumber ?? ''),
      MapEntry('account_name', record.accountName ?? ''),
      MapEntry('details', record.details),
      MapEntry('date', record.date.toIso8601String()),
      MapEntry('record_type', record.recordType),
      MapEntry('symbol', record.symbol),
      if (record.receiverId != null)
        MapEntry('receiver_id', '${record.receiverId}'),
    ]);
    if (record.newBookId != null) {
      data.fields.add(MapEntry('book_id', '${record.newBookId}'));
    }
    data.files.add(
      MapEntry(
        'file',
        MultipartFile.fromFileSync(
          record.file,
          filename: record.file.split(Platform.pathSeparator).last,
          contentType: MediaType(type, subtype),
        ),
      ),
    );
    var user = await postRequestHandler(
      path,
      data: data,
    );
    return user.data['message'];
  }

  Future<String> updateRecord({
    required CreateRecord record,
  }) async {
    var path = 'record/update';
    var data = {
      'record_id': record.id,
      'book_id': record.newBookId,
      'receiver_id': record.receiverId ?? LocalStorage.instance.getId(),
      'details': record.details,
      'edit_details': record.editDetails,
    };
    var user = await postRequestHandler(
      path,
      data: data,
    );
    return user.data['message'];
  }

  Future<String> confirmRecord({
    required CreateRecord record,
  }) async {
    var path = 'record/confirm';
    var data = {
      'record_id': record.id,
      'book_id': record.newBookId,
    };
    var user = await postRequestHandler(
      path,
      data: data,
    );
    return user.data['message'];
  }

  Future<String> updateProfile({
    String? name,
  }) async {
    var path = 'auth/update';
    var user = await postRequestHandler(
      path,
      data: {'name': name},
    );
    return user.data['message'];
  }

  // Future<String> updateBookView({required int bookId}) async {
  //   var path = 'book/view';
  //   var user = await postRequestHandler(
  //     path,
  //     data: {'id': bookId},
  //   );
  //   return user.data['message'];
  // }

  Future<String> markAllAsRead() async {
    var path = 'notification/mark-all-as-read';
    var user = await postRequestHandler(path);
    return user.data['message'];
  }

  // Future<String> updateRecordView({required int bookId}) async {
  //   var path = 'record/view';
  //   var user = await postRequestHandler(
  //     path,
  //     data: {'id': bookId},
  //   );
  //   return user.data['message'];
  // }

  Future<String> uploadPhoto({required File file}) async {
    var path = 'misc/upload';
    FormData data = FormData();
    String mimeType = mime(file.path) ?? '';
    String type = mimeType.split('/')[0];
    String subtype = mimeType.split('/')[1];
    data.files.add(
      MapEntry(
        'file',
        MultipartFile.fromFileSync(
          file.path,
          filename: file.path.split(Platform.pathSeparator).last,
          contentType: MediaType(type, subtype),
        ),
      ),
    );
    var user = await postRequestHandler(
      path,
      data: data,
      options: Options(
        headers: {
          HttpHeaders.contentTypeHeader: "multipart/form-data",
        },
      ),
    );
    var url = user.data['data']['url'];
    await LocalStorage.instance.setProfilePhoto(url);
    return url;
  }
}
