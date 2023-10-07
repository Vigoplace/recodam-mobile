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
  Pagination({this.page = 1, this.total = 100, this.size = 20});
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

class CreateBook {
  String name;
  String description;
  int openingBalance;
  String type;
  String access;

  CreateBook({
    required this.name,
    required this.description,
    required this.openingBalance,
    required this.type,
    required this.access,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'openingBalance': openingBalance,
      'type': type,
      'access': access,
    };
  }
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
  String description;
  int openingBalance;
  String type;
  String access;
  int userId;
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
    required this.createdAt,
    required this.updatedAt,
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
      createdAt: DateTime.parse(data['created_at']),
      updatedAt: DateTime.parse(data['updated_at']),
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
