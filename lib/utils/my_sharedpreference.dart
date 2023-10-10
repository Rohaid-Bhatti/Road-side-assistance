import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreference{
  final String isDark = "isDark";

  Future<void> setScreenData(bool isDark) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(this.isDark, isDark);
  }

  Future<bool> getScreenData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    bool isDark;
    isDark = pref.getBool(this.isDark) ?? false;
    return isDark;
  }
}