import 'package:recordam/utils/utils.dart';

class ActivityModel {
  final bool isLogout;
  final String message;
  ActivityModel({
    required this.isLogout,
    required this.message,
  });
}

class Pagination {
  int page;
  int total;
  int size;
  int? book;
  int limit;
  DateTime? lastDate;
  String search;
  int? id;
  Pagination({
    this.page = 1,
    this.total = 100,
    this.size = 20,
    this.book,
    this.search = '',
    this.lastDate,
    this.limit = 4,
    this.id,
  });
}

class ErrorResponse {
  final String? message;

  ErrorResponse({
    this.message = 'Something went wrong',
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> data) {
    return ErrorResponse(
      message: data['message'],
    );
  }
}

class ShareInfo {
  String name;
  String description;
  String code;

  ShareInfo({
    required this.code,
    required this.description,
    required this.name,
  });
}

class PinModel {
  final bool? showDiag;
  final bool toWithdrawal;
  PinModel({
    this.showDiag,
    this.toWithdrawal = false,
  });
}

class BankWithdrawalModel {
  final bool? isDefault;
  final bool toLogin;
  final bool sendInitialOTP;

  BankWithdrawalModel({
    this.isDefault,
    this.toLogin = false,
    this.sendInitialOTP = false,
  });
}

class WebViewModel {
  String url;
  String appBarText;
  WebViewModel({
    required this.appBarText,
    required this.url,
  });
}

class Create {
  final CreateRecordModel? bookId;
  final List<SharedFile> media;
  Create({
    this.bookId,
    this.media = const [],
  });
}

class CreateRecordModel {
  String? name;
  int? id;
  DetailType? type;
  CreateRecordModel({
    required this.name,
    required this.id,
    this.type,
  });
}

class CreateBook {
  String name;
  String description;
  int openingBalance;
  String type;
  String access;
  String symbol;

  CreateBook({
    required this.name,
    required this.description,
    required this.openingBalance,
    required this.type,
    required this.access,
    required this.symbol,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'openingBalance': openingBalance,
      'type': type,
      'access': access,
      'symbol': symbol,
    };
  }
}

class CreateRecord {
  String senderName;
  num amount;
  String? bankName;
  String? accountNumber;
  String? accountName;
  String details;
  DateTime date;
  String file;
  String recordType;
  String symbol;
  int? id;
  int? newBookId;
  int? newOwnerId;

  CreateRecord({
    required this.senderName,
    required this.amount,
    this.bankName,
    this.accountNumber,
    this.accountName,
    required this.details,
    required this.symbol,
    required this.date,
    required this.file,
    required this.recordType,
    this.id,
    this.newBookId,
    this.newOwnerId,
  });
}

class BookInfo {
  List<Book> book;
  int total;
  BookInfo({
    required this.book,
    required this.total,
  });

  factory BookInfo.fromJson(Map<String, dynamic> data) {
    return BookInfo(
      book: (data['books'] as List).map((e) => Book.fromJson(e)).toList(),
      total: data['total'],
    );
  }
}

class Book {
  int id;
  String name;
  num sum;
  String description;
  int openingBalance;
  String type;
  String access;
  String symbol;
  int userId;
  int totalRecords;
  DateTime? viewed;
  DateTime createdAt;
  DateTime updatedAt;

  Book({
    required this.id,
    required this.name,
    required this.description,
    required this.openingBalance,
    required this.type,
    required this.access,
    required this.userId,
    required this.symbol,
    required this.createdAt,
    required this.updatedAt,
    required this.totalRecords,
    required this.viewed,
    required this.sum,
  });

  factory Book.fromJson(Map<String, dynamic> data) {
    return Book(
      id: data['id'],
      name: data['name'],
      description: data['description'],
      openingBalance: data['opening_balance'],
      type: data['type'],
      access: data['access'],
      userId: data['user_id'],
      symbol: data['symbol'],
      sum: data['sum'] ?? 0,
      totalRecords: data['total_records'],
      createdAt: DateTime.parse(data['created_at']),
      updatedAt: DateTime.parse(data['updated_at']),
      viewed: data['viewed'] != null ? DateTime.parse(data['viewed']) : null,
    );
  }
}

class CountryModel {
  String flag;
  String country;
  String code;

  CountryModel({
    required this.flag,
    required this.country,
    required this.code,
  });

  factory CountryModel.fromJson(Map<String, dynamic> data) {
    return CountryModel(
      flag: data['flag'],
      country: data['country'],
      code: data['code'] ?? '',
    );
  }
}

class CurrencyModel {
  String symbol;
  String short;
  String name;
  String image;

  CurrencyModel({
    required this.symbol,
    required this.short,
    required this.name,
    required this.image,
  });

  factory CurrencyModel.fromJson(Map<String, dynamic> data) {
    return CurrencyModel(
      symbol: data['symbol'],
      short: data['short'],
      name: data['name'],
      image: data['image'],
    );
  }
}

class BankModel {
  String id;
  String code;
  String name;

  BankModel({
    required this.id,
    required this.code,
    required this.name,
  });

  factory BankModel.fromJson(Map<String, dynamic> data) {
    return BankModel(
      id: data['id'],
      code: data['code'],
      name: data['name'],
    );
  }
}

class NewRecord {
  final double amount;
  final String bankName;
  final String accountNumber;
  final String accountName;
  final String details;
  final DateTime date;
  final String file;
  final String recordType;

  NewRecord({
    required this.amount,
    required this.bankName,
    required this.accountNumber,
    required this.accountName,
    required this.details,
    required this.date,
    required this.file,
    required this.recordType,
  });

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'bank_name': bankName,
      'account_number': accountNumber,
      'account_name': accountName,
      'details': details,
      'date': date.toIso8601String(),
      'file': file,
      'record_type': recordType,
    };
  }
}

class RecordInfo {
  List<Record> book;
  int total;
  RecordInfo({
    required this.book,
    required this.total,
  });

  factory RecordInfo.fromJson(Map<String, dynamic> data) {
    return RecordInfo(
      book: (data['records'] as List).map((e) => Record.fromJson(e)).toList(),
      total: data['total'],
    );
  }
}

class RecordBook {
  int bookId;
  String? bookName;
  RecordBook({
    required this.bookId,
    this.bookName,
  });

  factory RecordBook.fromJson(Map<String, dynamic> data) {
    return RecordBook(
      bookId: data['book_id'],
      bookName: data['name'],
    );
  }
}

class ViewRecordInfo {
  Record record;
  DetailType type;

  ViewRecordInfo({
    required this.record,
    required this.type,
  });
}

class Record {
  int id;
  DateTime date;
  DateTime? viewed;
  String senderName;
  num amount;
  String? bankName;
  String? accountNumber;
  String? accountName;
  String details;
  String recordType;
  String file;
  String symbol;
  int ownerId;
  bool isDatabase;
  RecordBook? book;
  bool myRecord;

  Record({
    required this.id,
    required this.date,
    required this.senderName,
    required this.amount,
    required this.bankName,
    required this.accountNumber,
    required this.accountName,
    required this.details,
    required this.recordType,
    required this.file,
    required this.ownerId,
    required this.symbol,
    this.book,
    this.viewed,
    this.isDatabase = true,
    required this.myRecord,
  });

  factory Record.fromJson(Map<String, dynamic> data) {
    int myId = LocalStorage.instance.getId();
    return Record(
      id: data['id'] as int,
      date: DateTime.parse(data['date']),
      viewed: data['viewed'] != null ? DateTime.parse(data['viewed']) : null,
      senderName: data['sender_name'],
      amount: data['amount'],
      bankName: data['bank_name'],
      accountNumber: data['account_number'],
      accountName: data['account_name'],
      details: data['details'],
      recordType: data['record_type'],
      file: data['file'],
      ownerId: data['owner_id'],
      symbol: data['symbol'],
      book: data['book_id'] != null ? RecordBook.fromJson(data) : null,
      myRecord: myId == data['owner_id'] ? true : false,
    );
  }
}

class AddToBookInfo {
  ManageAcess title;
  String number;
  AddToBookInfo({
    required this.title,
    required this.number,
  });
}

class ButtonState {
  bool isLoading;
  bool send;

  ButtonState({
    this.isLoading = false,
    this.send = false,
  });
}

class Either<L, R> {
  final L? left;
  final R? right;
  const Either(this.left, this.right);

  Either.left(L value, this.left) : right = null;
  Either.right(R value, this.right) : left = null;

  bool get isLeft => left != null;
  bool get isRight => right != null;
}

class Right<L, R> extends Either<L, R> {
  final R _r;
  const Right(this._r) : super(null, _r);
  R get value => _r;

  @override
  bool operator ==(other) {
    if (other is Either<L, R>) {
      return (other).isRight == _r;
    }
    return false;
  }

  @override
  int get hashCode => _r.hashCode;
}

class Left<L, R> extends Either<L, R> {
  final L _l;
  const Left(this._l) : super(_l, null);
  L get value => _l;

  @override
  bool operator ==(other) {
    if (other is Either<L, R>) {
      return other.isRight == _l;
    }
    return false;
  }

  @override
  int get hashCode => _l.hashCode;
}

class PostBookInfo {
  UserData user;
  Book? book;
  PostBookInfo({
    required this.book,
    required this.user,
  });
}
