// import 'package:recordam/utils/utils.dart';

class CreateAccountModel {
  final String name;
  final String email;
  final String phone;
  final String password;

  CreateAccountModel({
    required this.email,
    required this.name,
    required this.password,
    required this.phone,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
    };
  }
}

class LoginModel {
  final String phone;
  final String password;

  LoginModel({
    required this.password,
    required this.phone,
  });

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'password': password,
    };
  }
}

class UserModel {
  final bool status;
  final String message;
  final UserData data;

  UserModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      status: json['status'],
      message: json['message'],
      data: UserData.fromJson(json['data']),
    );
  }
}

class UserData {
  final int id;
  final String email;
  final String name;
  final String createdAt;
  final String updatedAt;
  final String phone;
  final String token;

  UserData({
    required this.id,
    required this.email,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.phone,
    required this.token,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      phone: json['phone'],
      token: json['token'],
    );
  }
}

class CustomError {
  final bool status;
  final String message;

  CustomError({
    required this.status,
    required this.message,
  });

  factory CustomError.fromJson(Map<String, dynamic> json) {
    return CustomError(
      status: json['status'],
      message: json['message'],
    );
  }
}
