import 'package:flutter/services.dart';

class BottomSheetService {
  BottomSheetService._();

  static const platform = MethodChannel('com.example.ma_demo/bottomSheet');

  static Future<void> showFlutterBottomSheet() async {
    try {
      await platform.invokeMethod('showFlutterBottomSheet');
    } on PlatformException catch (e) {
      print("Failed to show Flutter bottom sheet: ${e.message}");
    }
  }
}
