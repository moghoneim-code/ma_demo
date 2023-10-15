import 'package:flutter/services.dart';

class BottomSheetService {
  BottomSheetService._();

  /// MethodChannel to communicate with native code threw platform channel
  static const platform = MethodChannel('com.example.ma_demo/bottomSheet');

  /// function to show native bottom sheet
  static Future<void> showFlutterBottomSheet() async {
    try {
      /// invokeMethod to call native method
      await platform.invokeMethod('showFlutterBottomSheet');
    } on PlatformException catch (e) {
      print("Failed to show Flutter bottom sheet: ${e.message}");
    }
  }
}
