package com.example.ma_demo
import android.content.Context
import android.view.LayoutInflater
import com.google.android.material.bottomsheet.BottomSheetDialog

class BottomSheetHelper(private val context: Context) {

    fun showBottomSheet() {
        val view = LayoutInflater.from(context).inflate(R.layout.bottom_sheet_layout, null)
        val dialog = BottomSheetDialog(context)
        dialog.setContentView(view)
        dialog.show()
    }


}