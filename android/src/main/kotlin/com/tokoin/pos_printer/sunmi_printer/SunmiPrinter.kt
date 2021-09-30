package com.tokoin.pos_printer.sunmi_printer

import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.os.RemoteException
import android.util.Base64
import android.util.Log
import com.tokoin.pos_printer.model.*
import java.util.*

const val PRINTER_CHARACTER_PER_LINE = 32
const val SUNMI_PRINTER_CHARACTER_PER_LINE_SMALL = 36
const val PRINTER_FONT_SIZE_NORMAL = 24f
const val PRINTER_FONT_SIZE_SMALL = 20f
const val MAX_IMAGE_WIDTH = 384

fun SunmiPrintHelper.print(commands: List<Command>) {
    if (sunmiPrinterService == null) {
        return
    }

    try {
        sunmiPrinterService.printerInit(null)

        for (command in commands) {
            if (command.blocks.isNotEmpty()) {
                when (command.blocks.first().align) {
                    POSAlign.Left -> sunmiPrinterService.setAlignment(0, null)
                    POSAlign.Center -> sunmiPrinterService.setAlignment(1, null)
                    POSAlign.Right -> sunmiPrinterService.setAlignment(2, null)
                }
            }

            when (command.type) {
                POSCommandType.Text -> {
                    if (command.blocks.size == 1) {
                        val block = command.blocks.first()

                        if (block.font == POSFont.Small) {
                            val content = StringUtils.wordWrap(block.content, SUNMI_PRINTER_CHARACTER_PER_LINE_SMALL, "", Locale.getDefault())
                            printText("$content\n", PRINTER_FONT_SIZE_SMALL, block.fontWeight == POSFontWeight.Bold, block.underline != POSUnderline.None)
                        } else {
                            val content = StringUtils.wordWrap(block.content, PRINTER_CHARACTER_PER_LINE, "", Locale.getDefault())
                            printText("$content\n", PRINTER_FONT_SIZE_NORMAL,block.fontWeight == POSFontWeight.Bold, block.underline != POSUnderline.None)
                        }
                    }
                }
                POSCommandType.KeyValue -> {
                    if (command.blocks.size == 2) {
                        val keyBlock = command.blocks[0]
                        val valueBlock = command.blocks[1]

                        val width = intArrayOf(2, 1)
                        val align = intArrayOf(0, 2)
                        val texts = arrayOf(keyBlock.content, valueBlock.content)

                        sunmiPrinterService.setAlignment(0, null)
                        sunmiPrinterService.printColumnsString(texts, width, align, null)
                    }
                }

                POSCommandType.Image -> {
                    if (command.blocks.size == 1) {
                        val block = command.blocks.first()

                        val bytes = Base64.decode(block.content, Base64.DEFAULT)
                        val bitmap = BitmapFactory.decodeByteArray(bytes, 0, bytes.size)
                        val gh = bitmap.width / MAX_IMAGE_WIDTH
                        val resizedBitmap = Bitmap.createScaledBitmap(bitmap,
                            MAX_IMAGE_WIDTH, bitmap.height / gh, false
                        )

                        sunmiPrinterService.printBitmap(resizedBitmap, null)
                    }
                }
                POSCommandType.Divider -> {
                    printLine()
                }
                POSCommandType.Linebreak -> sunmiPrinterService.lineWrap(1, null)
            }
        }

        sunmiPrinterService.autoOutPaper(null)

    } catch (e: RemoteException) {
        Log.d("PRINTER", e.toString())
    }
}