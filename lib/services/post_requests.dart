import 'dart:io';

import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';
import 'package:recordam/utils/utils.dart';

class PostRequest {
  static NetworkService network = NetworkService();

  static Future<void> test() async {
    // var path = '';
    // var _ = await network.getRequestHandler(path);
    await Future.delayed(const Duration(seconds: 2));
    return;
  }

  static Future<void> testSending(WidgetRef ref) async {
    // var path = '';
    // var _ = await network.getRequestHandler(path);
    ref.read(sendingProvider.notifier).state = true;
    await Future.delayed(const Duration(seconds: 2));
    ref.read(sendingProvider.notifier).state = false;
    await LocalStorage.instance.prefs.clear();
    return;
  }

  static Future<UserModel> createAccount({
    required CreateAccountModel createAccountModel,
  }) async {
    var path = 'auth/create';
    var user = await network.postRequestHandler(
      path,
      data: createAccountModel.toJson(),
    );
    return UserModel.fromJson(user.data);
  }

  static Future<UserModel> loginToAccount({
    required LoginModel loginModel,
  }) async {
    var path = 'auth/login';
    var user = await network.postRequestHandler(
      path,
      data: loginModel.toJson(),
    );
    return UserModel.fromJson(user.data);
  }

  static Future<String> forgotPassword({
    required String email,
  }) async {
    var path = 'auth/forgot-password';
    var user = await network.postRequestHandler(
      path,
      data: {'email': email},
    );
    return user.data['message'];
  }

  static Future<String> resetPassword({
    required String otp,
    required String pin,
  }) async {
    var path = 'auth/reset-password';
    var email = LocalStorage.instance.getEmail();
    var user = await network.postRequestHandler(
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

  static Future<String> createBook({
    required CreateBook book,
  }) async {
    var path = 'book/create';
    var token = LocalStorage.instance.getToken();
    var user = await network.postRequestHandler(
      path,
      data: book.toJson(),
      options: Options(
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
      ),
    );
    return user.data['message'];
  }

  static Future<String> createRecord({
    required CreateRecord record,
  }) async {
    var path = 'record/create';
    var token = LocalStorage.instance.getToken();
    FormData data = FormData();
    String mimeType = mime(record.file)!;
    String type = mimeType.split('/')[0];
    String subtype = mimeType.split('/')[1];
    // late String file;

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
    var user = await network.postRequestHandler(
      path,
      data: data,
      options: Options(
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
      ),
    );
    return user.data['message'];
  }

  static Future<String> updateRecord({
    required CreateRecord record,
  }) async {
    var path = 'record/update';
    var token = LocalStorage.instance.getToken();
    var data = {
      'id': record.id,
      'book_id': record.newBookId,
      'details': record.details,
    };
    var user = await network.postRequestHandler(
      path,
      data: data,
      options: Options(
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
      ),
    );
    return user.data['message'];
  }

  static Future<String> updateProfile({
    required WidgetRef ref,
    String? name,
  }) async {
    var path = 'auth/update';
    var token = LocalStorage.instance.getToken();
    ref.read(sendingProvider.notifier).state = true;
    var user = await network.postRequestHandler(
      path,
      data: {'name': name},
      options: Options(
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
      ),
    );
    ref.read(sendingProvider.notifier).state = false;
    return user.data['message'];
  }

  static Future<String> uploadPhoto({
    required WidgetRef ref,
    required File file,
  }) async {
    var path = 'misc/upload';
    var token = LocalStorage.instance.getToken();
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
    var user = await network.postRequestHandler(
      path,
      data: data,
      options: Options(
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: "multipart/form-data",
        },
      ),
    );
    ref.read(sendingProvider.notifier).state = false;
    return user.data['data']['url'];
  }
}
