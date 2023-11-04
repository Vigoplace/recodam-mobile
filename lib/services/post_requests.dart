import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';
import 'package:recordam/utils/utils.dart';

class PostRequest extends NetworkService {
  static final PostRequest instance = PostRequest._init();
  PostRequest._init();

  Future<void> test() async {
    // var path = '';
    // var _ = await getRequestHandler(path);
    await Future.delayed(const Duration(seconds: 2));
    return;
  }

  Future<void> testSending(WidgetRef ref) async {
    // var path = '';
    // var _ = await getRequestHandler(path);
    ref.read(sendingProvider.notifier).state = true;
    await Future.delayed(const Duration(seconds: 2));
    ref.read(sendingProvider.notifier).state = false;
    await LocalStorage.instance.prefs.clear();
    return;
  }

  Future<UserModel> createAccount({
    required CreateAccountModel createAccountModel,
  }) async {
    var path = 'auth/create';
    var payload = createAccountModel.toJson();
    var messagingToken = await FirebaseMessaging.instance.getToken();
    payload.addAll({'messaging_token': messagingToken});
    var user = await postRequestHandler(
      path,
      data: payload,
    );
    return UserModel.fromJson(user.data);
  }

  Future<UserModel> loginToAccount({
    required LoginModel loginModel,
  }) async {
    var path = 'auth/login';
    var payload = loginModel.toJson();
    var messagingToken = await FirebaseMessaging.instance.getToken();
    payload.addAll({'messaging_token': messagingToken});
    var user = await postRequestHandler(
      path,
      data: payload,
    );
    return UserModel.fromJson(user.data);
  }

  Future<String> forgotPassword({
    required String email,
  }) async {
    var path = 'auth/forgot-password';
    var user = await postRequestHandler(
      path,
      data: {'email': email},
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
      MapEntry('account_number', record.accountName ?? ''),
      MapEntry('account_name', record.accountName ?? ''),
      MapEntry('details', record.details),
      MapEntry('date', record.date.toIso8601String()),
      MapEntry('record_type', record.recordType),
      MapEntry('symbol', record.symbol),
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
      'id': record.id,
      'book_id': record.newBookId,
      'owner_id': record.newOwnerId,
      'details': record.details,
    };
    var user = await postRequestHandler(
      path,
      data: data,
    );
    return user.data['message'];
  }

  Future<String> updateProfile({
    required WidgetRef ref,
    String? name,
  }) async {
    var path = 'auth/update';
    ref.read(sendingProvider.notifier).state = true;
    var user = await postRequestHandler(
      path,
      data: {'name': name},
    );
    ref.read(sendingProvider.notifier).state = false;
    return user.data['message'];
  }

  Future<String> updateBookView({required int bookId}) async {
    var path = 'book/view';
    var user = await postRequestHandler(
      path,
      data: {'id': bookId},
    );
    return user.data['message'];
  }

  Future<String> updateRecordView({required int bookId}) async {
    var path = 'record/view';
    var user = await postRequestHandler(
      path,
      data: {'id': bookId},
    );
    return user.data['message'];
  }

  Future<String> uploadPhoto({
    required WidgetRef ref,
    required File file,
  }) async {
    var path = 'misc/upload';
    ref.read(sendingProvider.notifier).state = true;
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
    ref.read(sendingProvider.notifier).state = false;
    return user.data['data']['url'];
  }
}
