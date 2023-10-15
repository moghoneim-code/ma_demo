package com.example.ma_demo
import android.os.Bundle
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {

        Log.e("MainActivity", "onCreate")
        super.onCreate(savedInstanceState)
        val channel = MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, "com.example.ma_demo/bottomSheet")
        channel.setMethodCallHandler { call, result ->
            when (call.method) {
                "showFlutterBottomSheet" -> {
                    showFlutterBottomSheet()
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun showFlutterBottomSheet() {
        val bottomSheetHelper = BottomSheetHelper(this)
        bottomSheetHelper.showBottomSheet()
    }
}