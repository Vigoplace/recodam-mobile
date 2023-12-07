// import 'package:recordam/utils/utils.dart';

class CreateAccountModel {
  final String name;
  final String email;
  final String phone;
  final String password;
  final String countryCode;

  CreateAccountModel({
    required this.email,
    required this.name,
    required this.password,
    required this.phone,
    required this.countryCode,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'country_code': countryCode,
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

  factory UserModel.fromJson(Map<String, dynamic> data) {
    return UserModel(
      status: data['status'],
      message: data['message'],
      data: UserData.fromJson(data['data']),
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
  final String? profilePhoto;

  UserData({
    required this.id,
    required this.email,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.phone,
    required this.token,
    required this.profilePhoto,
  });

  factory UserData.fromJson(Map<String, dynamic> data) {
    return UserData(
      id: data['id'],
      email: data['email'],
      name: data['name'],
      createdAt: data['created_at'],
      updatedAt: data['updated_at'],
      phone: data['phone'],
      token: data['token'],
      profilePhoto: data['profile_photo'],
    );
  }
}

class RecordsDetails {
  final int posted;
  final int unconfirmed;

  RecordsDetails({
    required this.posted,
    required this.unconfirmed,
  });

  factory RecordsDetails.fromJson(Map<String, dynamic> data) {
    return RecordsDetails(
      posted: data['posted'],
      unconfirmed: data['unconfirmed'],
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

  factory CustomError.fromJson(Map<String, dynamic> data) {
    return CustomError(
      status: data['status'],
      message: data['message'],
    );
  }
}
