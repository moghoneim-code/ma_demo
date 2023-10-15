import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:ma_demo/constants/K_themes.dart';

import 'package:ma_demo/shared/providers/app_settings_provider.dart';
import 'package:provider/provider.dart';

import 'modules/main_page/screens/main_page_screen.dart';
import 'modules/reservation/providers/reservation_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  runApp(MyApp(savedThemeMode: savedThemeMode));
}

class MyApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;

  const MyApp({super.key, this.savedThemeMode});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: KThemes.lightModeTheme,
      dark: KThemes.darkModeTheme,
      initial: savedThemeMode ?? AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AppSettingProvider()),
        ],
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => AppSettingProvider()),
            ChangeNotifierProvider(create: (context) => ReservationProvider()),
          ],
          child: MaterialApp(
            title: 'Adaptive Theme Demo',
            theme: theme,
            darkTheme: darkTheme,
            home: const MainPageScreen(),
          ),
        ),
      ),
    );
  }
}

