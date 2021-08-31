package com.tokoin.pos_printer.bluetooth_printer

import android.graphics.Bitmap
import com.dantsu.escposprinter.textparser.PrinterTextParserImg

class PrinterData {
    var data: String = ""

    fun text(text: String) {
        data += "$text"
    }

//    fun image(bitmap: Bitmap) {
//        data += "[C]<img>" + PrinterTextParserImg.bitmapToHexadecimalString(
//            printer,
//            bitmap
//        ) + "</img>\n"
//    }
}