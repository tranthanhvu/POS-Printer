package com.tokoin.pos_printer.bluetooth_printer

import android.graphics.Bitmap
import com.dantsu.escposprinter.textparser.PrinterTextParserImg

class PrinterData {
    var data: String = ""

    fun text(text: String) {
        data += "$text"
    }

    fun image(imgText: String) {
        data += "[C]<img>" + imgText + "</img>\n"
    }

    fun linebreak(num: Int = 1) {
        for (i: Int in 0..num) {
            data += "\n";
        }
    }

    fun divider() {

    }
}