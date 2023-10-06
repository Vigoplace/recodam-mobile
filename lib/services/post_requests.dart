import 'dart:io';

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
}
