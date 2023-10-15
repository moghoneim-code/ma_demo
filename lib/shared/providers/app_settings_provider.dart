import 'package:flutter/cupertino.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

class AppSettingProvider extends ChangeNotifier {
  /// listen on dark mode changes

  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

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

  set isDarkMode(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }
}
