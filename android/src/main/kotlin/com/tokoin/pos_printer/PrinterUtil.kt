package com.tokoin.pos_printer

import android.content.Context
import android.util.Log
import com.tokoin.pos_printer.bluetooth_printer.AsyncBluetoothEscPosPrint
import com.tokoin.pos_printer.bluetooth_printer.AsyncEscPosPrinter
import com.tokoin.pos_printer.model.Command
import com.tokoin.pos_printer.sunmi_printer.BluetoothUtil
import com.tokoin.pos_printer.sunmi_printer.SunmiPrintHelper
import com.tokoin.pos_printer.sunmi_printer.print
import org.json.JSONArray
import java.util.*
import kotlin.collections.ArrayList
import kotlin.concurrent.schedule

class PrinterUtil {
    companion object {
        fun testPrint(context: Context) {
            val json = "[{'blocks':[{'content': 'RECEIPT'}]}]"

            print(context, commandsJSON = json)
        }

        fun print(context: Context, commandsJSON: String) {
            val json = JSONArray(commandsJSON)
            val commands = ArrayList<Command>()
            for (i in 0 until json.length()) {
                val command = Command(json.getJSONObject(i).toString())
                commands.add(command)
            }

            print(context, commands)
        }

        private fun print(context: Context, commands: List<Command>) {
            if (isSunmiPrinter()) {
                SunmiPrintHelper.getInstance().print(commands)
            } else {
                val printer = getAsyncEscPosPrinter(commands = commands)
                if (printer != null) {
                    Log.d("PRINTER", printer.textToPrint)
                }

                AsyncBluetoothEscPosPrint(context).execute(printer)
            }
        }

        private fun getAsyncEscPosPrinter(commands: List<Command>): AsyncEscPosPrinter? {
            val printer = AsyncEscPosPrinter(null, 203, 48f, 32)

            return printer.setCommands(commands)
        }

        fun isSunmiPrinter(): Boolean {
            return SunmiPrintHelper.getInstance().sunmiPrinter == SunmiPrintHelper.FoundSunmiPrinter
        }

        fun checkSunmiPrinter(context: Context) {
            BluetoothUtil.isBlueToothPrinter?.let {
                when (SunmiPrintHelper.getInstance().sunmiPrinter) {
                    SunmiPrintHelper.CheckSunmiPrinter -> {
                        Timer("check sunmi printer", false).schedule(2000) { checkSunmiPrinter(context) }
                    }
                    SunmiPrintHelper.NoSunmiPrinter, SunmiPrintHelper.FoundSunmiPrinter -> {}
                    else -> SunmiPrintHelper.getInstance().initSunmiPrinterService(context)

                }

                SunmiPrintHelper.getInstance().initPrinter()
            }
        }
    }
}
