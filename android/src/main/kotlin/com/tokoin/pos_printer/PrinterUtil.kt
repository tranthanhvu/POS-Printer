package com.tokoin.pos_printer

import android.content.Context
import android.graphics.Bitmap
import com.dantsu.escposprinter.connection.DeviceConnection
import com.tokoin.pos_printer.bluetooth_printer.AsyncBluetoothEscPosPrint
import com.tokoin.pos_printer.bluetooth_printer.AsyncEscPosPrinter
import com.tokoin.pos_printer.model.Command

class PrinterUtil {
    companion object {
        fun testPrint(context: Context) {
            val command = Command("{'blocks':[{'content': 'RECEIPT'}]}")
            AsyncBluetoothEscPosPrint(context).execute(getAsyncEscPosPrinter(null, commands = listOf(command)))
        }

        fun print(context: Context, commands: List<Command>) {
            AsyncBluetoothEscPosPrint(context).execute(getAsyncEscPosPrinter(null, commands = commands))
        }

        private fun getAsyncEscPosPrinter(
            printerConnection: DeviceConnection?,
            commands: List<Command>
        ): AsyncEscPosPrinter? {
            val printer = AsyncEscPosPrinter(printerConnection, 203, 48f, 32)

            return printer.setCommands(commands)
        }

    }
}
