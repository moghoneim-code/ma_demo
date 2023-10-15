import 'package:flutter/cupertino.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

class AppSettingProvider extends ChangeNotifier {
  /// variable to check if the app is in dark mode or not
  bool _isDarkMode = false;

  /// getter to get the value of isDarkMode
  bool get isDarkMode => _isDarkMode;

  /// constructor to initialize the value of isDarkMode from local storage when the app starts
  AppSettingProvider() {
    AdaptiveTheme.getThemeMode().then((themeMode) {
      if (themeMode == AdaptiveThemeMode.dark) {
        _isDarkMode = true;
      } else {
        _isDarkMode = false;
      }
      notifyListeners();
    });
  }

  /// function to set the app to dark mode
  void setDarkMode(BuildContext context) {
    AdaptiveTheme.of(context).setDark();
  }

  /// function to set the app to light mode
  void setLightMode(BuildContext context) {
    AdaptiveTheme.of(context).setLight();
  }

  /// setter to set the value of isDarkMode
  set isDarkMode(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }
}
