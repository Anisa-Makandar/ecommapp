import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Theme_manager extends ChangeNotifier {
  bool is_dark = false;
  static final theme = "isDark";
  Theme_manager() {
    setTheme();
  }

  bool getThemevalue() => is_dark;
  void changeTheme(bool value) {
    is_dark = value;
    saveTheme(value);
    notifyListeners();
  }

  void saveTheme(bool isDark) async {
    SharedPreferences mpref = await SharedPreferences.getInstance();
    mpref.setBool(theme, isDark);
  }

  void setTheme() async {
    SharedPreferences mpref = await SharedPreferences.getInstance();
    is_dark = mpref.getBool(theme) ?? false;
    //mpref.setBool(theme, isDark);
    //isDark=isDark;
    notifyListeners();
  }
}
