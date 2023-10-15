import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:ma_demo/constants/K_themes.dart';

import 'package:ma_demo/shared/providers/app_settings_provider.dart';
import 'package:provider/provider.dart';

import 'modules/main_page/screens/main_page_screen.dart';
import 'modules/reservation/providers/reservation_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Get saved theme mode from local storage
  final savedThemeMode = await AdaptiveTheme.getThemeMode();

  /// pass saved theme mode to MyApp
  runApp(MyApp(savedThemeMode: savedThemeMode));
}

class MyApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;

  const MyApp({super.key, this.savedThemeMode});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      /// Light and dark themes
      light: KThemes.lightModeTheme,

      /// each theme has its own colors , Styles, etc.
      dark: KThemes.darkModeTheme,

      /// initial theme from saved theme mode
      initial: savedThemeMode ?? AdaptiveThemeMode.light,

      /// wrap our app with MultiProvider to provide our providers to all app
      builder: (theme, darkTheme) => MultiProvider(
        providers: [
          /// app setting provider that contains all app settings [ in this case only dark mode management ]
          ChangeNotifierProvider(create: (context) => AppSettingProvider()),

          /// reservation provider that contains all reservation data and logic
          ChangeNotifierProvider(create: (context) => ReservationProvider()),
        ],
        child: MaterialApp(
          title: 'MA Demo',
          theme: theme,
          darkTheme: darkTheme,
          home: const MainPageScreen(),
        ),
      ),
    );
  }
}
