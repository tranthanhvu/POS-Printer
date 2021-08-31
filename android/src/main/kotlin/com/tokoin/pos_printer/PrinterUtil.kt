package com.tokoin.pos_printer

import android.content.Context
import android.graphics.Bitmap
import com.dantsu.escposprinter.connection.DeviceConnection
import com.tokoin.pos_printer.bluetooth_printer.AsyncBluetoothEscPosPrint
import com.tokoin.pos_printer.bluetooth_printer.AsyncEscPosPrinter

class PrinterUtil {
    companion object {
        fun testPrint(context: Context) {
            AsyncBluetoothEscPosPrint(context).execute(getAsyncEscPosPrinter(null))
        }

//        fun print(bitmap: Bitmap? = null) {
//            // if (SunmiPrintHelper.getInstance().sunmiPrinter == SunmiPrintHelper.FoundSunmiPrinter) {
//            //     SunmiPrintHelper.getInstance().printTicket(receipt!!, saleInfo!!, bitmap)
//            // } else {
//            AsyncBluetoothEscPosPrint(context).execute(getAsyncEscPosPrinter(null, bitmap = bitmap))
//            // }
//        }

        private fun getAsyncEscPosPrinter(
            printerConnection: DeviceConnection?,
            bitmap: Bitmap? = null
        ): AsyncEscPosPrinter? {
            val printer = AsyncEscPosPrinter(printerConnection, 203, 48f, 32)

            return printer.setTextToPrint("RECEIPT")
        }
    }
}
