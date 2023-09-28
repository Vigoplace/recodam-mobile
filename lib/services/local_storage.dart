import 'package:recordam/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static final LocalStorage instance = LocalStorage._init();
  LocalStorage._init();
  late SharedPreferences _prefs;

  Future<void> initialise() async {
    _prefs = await SharedPreferences.getInstance();
  }

  SharedPreferences get prefs {
    return _prefs;
  }

  final String _token = 'token';
  final String _name = 'name';
  final String _id = 'id';
  final String _email = 'email';
  final String _phone = 'phone';
  final String _updatedAt = 'updatedAt';
  final String _createdAt = 'createdAt';
  final String _loggedIn = 'loggedIn';
  final String _firstTime = 'firstTime';

  Future<void> saveUserInfo(UserData userData) async {
    await prefs.setString(_token, userData.token);
    await prefs.setString(_email, userData.email);
    await prefs.setString(_phone, userData.phone);
    await prefs.setString(_name, userData.name);
    await prefs.setString(_updatedAt, userData.updatedAt);
    await prefs.setString(_createdAt, userData.createdAt);
    await prefs.setInt(_id, userData.id);
    await prefs.setBool(_loggedIn, true);
    return;
  }

  String getName() {
    return prefs.getString(_name)!;
  }

  bool getFirstTime() {
    return prefs.getBool(_firstTime) ?? true;
  }

  Future<bool> setFirstTime() async {
    return await prefs.setBool(_firstTime, true);
  }

  bool getLoggedIn() {
    return prefs.getBool(_loggedIn)!;
  }
}
