import 'package:flutter/material.dart';

class KColors {
  KColors._();
 /// Main Color of the app in the light mode
  static const Color mainColorLightMode = Color(0xff0E1A2D);
  /// Main Color of the app in the dark mode
  static const Color mainColorDarkMode = Color(0xffE0E6F3);
  ///
  static const Color switchColorLight = Color(0xffE3E3E3);
  static const Color handleColorDarkMode = Color(0xff575E69);
  static const Color darknessColor = Color(0xFF1E1E1E);
  static const Color iconThemeColor = Color(0xFFBDBDBD);

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
