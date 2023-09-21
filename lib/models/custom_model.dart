class ActivityModel {
  final bool isLogout;
  final String message;
  ActivityModel({
    required this.isLogout,
    required this.message,
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
