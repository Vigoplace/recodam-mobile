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

  // final String _token = 'token';
}
