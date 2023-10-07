import 'dart:io';
import 'package:recordam/utils/utils.dart';

class GetRequest {
  static NetworkService network = NetworkService();

  static Future<String> test() async {
    // var path = '';
    // var _ = await network.getRequestHandler(path);
    var _ = await Future.delayed(const Duration(seconds: 3), () => 'Hello');
    return _;
  }

  static Future<List<int>> testPagination({Pagination? pagination}) async {
    // var path = '';
    // var _ = await network.getRequestHandler(path);
    var _ = await Future.delayed(const Duration(seconds: 3), () => 'Hello');
    return List.generate(10, (index) => index += 1);
  }

  static Future<List<Book>> getAllBooks({Pagination? pagination}) async {
    var path = 'book';
    var token = LocalStorage.instance.getToken();
    var books = await network.getRequestHandler(
      path,
      queryPatameters: {'page': pagination?.page, 'size': pagination?.size},
      options: Options(
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
      ),
    );
    debugPrint(books.data.toString());
    var bookInfo = BookInfo.fromJson(books.data['data']);
    pagination?.total = bookInfo.total;
    pagination?.page += 1;
    return bookInfo.book;
  }

  static Future<List<CountryModel>> getAllCountries(
      {Pagination? pagination}) async {
    var path = 'misc/countries';
    var countries = await network.getRequestHandler(path);
    return (countries.data['data'] as List)
        .map((e) => CountryModel.fromJson(e))
        .toList();
  }

  static Future<String> logout({required WidgetRef ref}) async {
    var path = 'auth/logout';
    var token = LocalStorage.instance.getToken();
    ref.read(sendingProvider.notifier).state = true;
    var user = await network.getRequestHandler(
      path,
      options: Options(
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
      ),
    );
    await LocalStorage.instance.prefs.clear();
    ref.read(sendingProvider.notifier).state = false;
    return user.data['message'];
  }
}
