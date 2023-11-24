import 'package:recordam/utils/utils.dart';

class GetRequest extends NetworkService {
  static final GetRequest instance = GetRequest._init();
  GetRequest._init();
  Future<String> test() async {
    // var path = '';
    // var _ = await getRequestHandler(path);
    var _ = await Future.delayed(const Duration(seconds: 3), () => 'Hello');
    return _;
  }

  Future<List<int>> testPagination({Pagination? pagination}) async {
    // var path = '';
    // var _ = await getRequestHandler(path);
    var _ = await Future.delayed(const Duration(seconds: 3), () => 'Hello');
    return List.generate(10, (index) => index += 1);
  }

  Future<Map<DateTime, List<Book>>> getGroupedBooks({
    required Pagination pagination,
  }) async {
    var path = 'book/group';
    var books = await getRequestHandler(
      path,
      queryPatameters: {
        'limit': pagination.limit,
        'offset': pagination.lastDate == null
            ? null
            : '${pagination.lastDate!.year}-${pagination.lastDate!.month}-${pagination.lastDate!.day}',
      },
    );
    Map<DateTime, List<Book>> groupedBooks = {};
    (books.data['data']['books'] as Map).forEach((key, value) {
      // Parse the date key into a DateTime object
      var date = DateTime.parse(key);
      var booksList = (value as List).map((bookJson) {
        return Book.fromJson(
            bookJson); // Assuming you have a fromJson constructor in your Book class
      }).toList();
      groupedBooks[date] = booksList;
    });
    if (groupedBooks.isEmpty) return {};
    pagination.total = books.data['data']['total'];
    pagination.lastDate = groupedBooks.keys.last;
    return groupedBooks;
  }

  Future<Map<DateTime, List<Record>>> getGroupedRecords({
    required Pagination pagination,
  }) async {
    var path = 'record/group';
    var books = await getRequestHandler(
      path,
      queryPatameters: {
        'limit': pagination.limit,
        'offset': pagination.lastDate == null
            ? null
            : '${pagination.lastDate!.year}-${pagination.lastDate!.month}-${pagination.lastDate!.day}',
      },
    );
    Map<DateTime, List<Record>> groupedBooks = {};
    (books.data['data']['records'] as Map).forEach((key, value) {
      // Parse the date key into a DateTime object
      var date = DateTime.parse(key);
      var booksList = (value as List).map((bookJson) {
        return Record.fromJson(
            bookJson); // Assuming you have a fromJson constructor in your Book class
      }).toList();
      groupedBooks[date] = booksList;
    });
    if (groupedBooks.isEmpty) return {};
    pagination.total = books.data['data']['total'];
    pagination.lastDate = groupedBooks.keys.last;
    return groupedBooks;
  }

  Future<List<Book>> getAllBooks({Pagination? pagination}) async {
    var path = 'book';
    var books = await getRequestHandler(
      path,
      queryPatameters: {
        'page': pagination?.page,
        'size': pagination?.size,
        'search': pagination?.search,
        'id': pagination?.id,
      },
    );
    var bookInfo = BookInfo.fromJson(books.data['data']);
    pagination?.total = bookInfo.total;
    pagination?.page += 1;
    return bookInfo.book;
  }

  Future<List<Record>> getRecords({Pagination? pagination}) async {
    var path = 'record';
    if (pagination?.book != null) {
      path = 'book/${pagination!.book}';
    }
    var books = await getRequestHandler(
      path,
      queryPatameters: {
        'page': pagination?.page,
        'size': pagination?.size,
        'search': pagination?.search,
      },
    );
    var bookInfo = RecordInfo.fromJson(books.data['data']);
    pagination?.total = bookInfo.total;
    pagination?.page += 1;
    return bookInfo.book;
  }

  Future<List<Record>> getHomeRecords({Pagination? pagination}) async {
    var path = 'record';
    if (pagination?.book != null) {
      path = 'book/${pagination!.book}';
    }
    var books = await getRequestHandler(
      path,
      queryPatameters: {
        'page': pagination?.page,
        'size': pagination?.size,
        'search': pagination?.search,
        'type': 'no-book', // Two kinds, NO-BOOK AND ALL
      },
    );
    var bookInfo = RecordInfo.fromJson(books.data['data']);
    pagination?.total = bookInfo.total;
    pagination?.page += 1;
    return bookInfo.book;
  }

  Future<List<CountryModel>> getAllCountries({Pagination? pagination}) async {
    var path = 'misc/countries';
    var countries = await getRequestHandler(path);
    return (countries.data['data'] as List)
        .map((e) => CountryModel.fromJson(e))
        .toList();
  }

  Future<List<CurrencyModel>> getAllCurrencies({Pagination? pagination}) async {
    var path = 'misc/currencies';
    var countries = await getRequestHandler(path);
    return (countries.data['data'] as List)
        .map((e) => CurrencyModel.fromJson(e))
        .toList();
  }

  Future<List<BankModel>> getAllBanks({Pagination? pagination}) async {
    var path = 'misc/banks';
    var countries = await getRequestHandler(path);
    return (countries.data['data'] as List)
        .map((e) => BankModel.fromJson(e))
        .toList();
  }

  Future<String> logout({required WidgetRef ref}) async {
    var path = 'auth/logout';
    ref.read(sendingProvider.notifier).state = true;
    var user = await getRequestHandler(
      path,
    );
    await LocalStorage.instance.prefs.clear();
    ref.read(sendingProvider.notifier).state = false;
    return user.data['message'];
  }

  Future<UserData> getUserNumber({
    required String number,
    bool infoOnly = false,
    Pagination? pagination,
  }) async {
    var path = 'users/$number';
    var user = await getRequestHandler(path);
    return UserData.fromJson(user.data['data']);
  }
}
