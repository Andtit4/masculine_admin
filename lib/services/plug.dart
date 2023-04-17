import 'package:shared_preferences/shared_preferences.dart';

class PageControl {
  togglePageShow(bool val, SharedPreferences prefs) {
    return prefs.setBool('show', val);
  }

  togglePageShowGet(SharedPreferences prefs) {
    return prefs.getBool('show');
  }

  Future<bool> setUserNumber(String value, SharedPreferences prefs) {
    return prefs.setString('telephoneuser', value);
  }

  String? getUserNumber(SharedPreferences prefs) {
    return prefs.getString('telephoneuser');
  }
}
