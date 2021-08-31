package com.tokoin.pos_printer

import android.graphics.Bitmap
import android.os.RemoteException
import android.text.format.DateFormat
import com.dantsu.escposprinter.textparser.PrinterTextParserImg
import com.tokoin.pos_printer.bluetooth_printer.AsyncEscPosPrinter
//import com.tokoin.pos_printer.model.Receipt
import java.util.*

class ReceiptUtil {

    /***
     * Using this function to get print content for normal pos thermal printer
     */
//    fun getPrintee(
//        receipt: Receipt?,
//        bitmap: Bitmap?,
//        printer: AsyncEscPosPrinter
//    ): String {
//        val storeName = saleInfo.storeName
//
//        val posName = receipt.posName
//        val receiptNumber = receipt.saleNumber
//        val date = saleInfo.receiptDate
//
//        var text =  ""
//        if (bitmap != null) {
//            text += "[C]<img>" + PrinterTextParserImg.bitmapToHexadecimalString(
//                printer,
//                bitmap
//            ) + "</img>\n"
//        }
//        text += "[C]<b>$storeName</b>\n"
//        val address = StringUtils.wordWrap(saleInfo.fullAddress, printer.printerNbrCharactersPerLine, "", Locale.getDefault())
//        val linesAddress = address.split("\n")
//        for (line in linesAddress) {
//            text += "[C]$line<\n"
//        }
//
//        if (saleInfo.storePhoneNumber.isNotEmpty()) {
//            text += "[C]${saleInfo.storePhoneNumber}\n"
//        }
//
//        text += "[C]--------------------------------\n" +
//                "[C]${posName}\n" +
//                "[C]--------------------------------\n" +
//                "[L]${DateFormat.format("dd-MM-yyyy", date)} [R]${DateFormat.format("HH:mm", date)}\n" +
//                "[L]Ticket No: ${receiptNumber}\n" +
//                "[L]Cashier: ${saleInfo.employeeName}\n"
//
//        receipt.customerName?.takeIf { it.isNotEmpty() }?.let {
//            text += "[L]\n" +
//                    "[L]${it}\n"
//        }
//        receipt.customerPhoneNumber?.let {
//            text += "[L]${it}\n"
//        }
//        receipt.diningOptionName?.let {
//            text += "[L]${it}\n"
//        }
//
//        receipt.shippingAddress?.addressInfo?.let {
//            if (it.isNotEmpty()) {
//                val shippingAddress = StringUtils.wordWrap(it, printer.printerNbrCharactersPerLine, "[L]", Locale.getDefault())
//                text += "[L]$shippingAddress\n"
//            }
//        }
//
//        text += "[C]--------------------------------\n" +
//                "[C]- Order Details -\n" +
//                "[L]\n"
//
//        receipt.items?.forEach { saleItem ->
//            val strPrice = CommonHelper.getRoundDoubleWithCurrency(saleItem.price, withCurrency = false)
//            val strQuantity = CommonHelper.roundDouble(saleItem.quantity)
//            val strAmount = CommonHelper.getRoundDoubleWithCurrency(saleItem.price * saleItem.quantity, withCurrency = false)
//            var strVariant:String? = null
//            if (saleItem.selectedVariantCombination != null) {
//                strVariant = "(${saleItem.selectedVariantCombination?.value})"
//            }
//            val strDiscount = if (saleItem.discountValue() > 0) {
//                "- ${CommonHelper.getRoundDoubleWithCurrency(saleItem.discountValue() * saleItem.quantity, withCurrency = false)}"
//            } else ""
//            val itemLength = printer.printerNbrCharactersPerLine - maxOf(strDiscount.length, strAmount.length) - 1
//            val strName = StringUtils.wordWrap(saleItem.name, itemLength, "", Locale.getDefault())
//            val lines = strName.split("\n").toMutableList()
//            strVariant?.let {
//                lines.add(it)
//            }
//            lines.add("$strQuantity x $strPrice")
//
//            for ((index, value) in lines.withIndex()) {
//                text += if (index == 0) {
//                    "[L]${value}[R]$strAmount\n"
//                } else if (index == 1) {
//                    "[L]${value}[R]$strDiscount\n"
//                } else {
//                    "[L]${value}\n"
//                }
//            }
//        }
//
//        text += "[C]--------------------------------\n"
//        val subTotalDiscount = receipt.discounts?.sumByDouble {
//            if (it.discountType == Enums.DiscountType.PERCENTAGE.toString()) it.calculatedDiscount() else it.value } ?: 0.toDouble()
//        val itemsDiscount = receipt.discountedAmount - subTotalDiscount
//        val subTotalAmountText = CommonHelper.getRoundDoubleWithCurrency(receipt.grossAmount - receipt.additionalCosts.sumByDouble { it.cost }, 2)
//        val itemDiscountText = CommonHelper.getRoundDoubleWithCurrency(itemsDiscount, 2)
//        val subTotalDiscountText =  CommonHelper.getRoundDoubleWithCurrency(subTotalDiscount, 2)
//        val totalAmountText =  CommonHelper.getRoundDoubleWithCurrency(receipt.netAmount + receipt.additionalCosts.sumByDouble { it.cost }, 2)
//        text += "[L]Subtotal [R]$subTotalAmountText\n" +
//                "[L]Discount [R]$itemDiscountText\n"
//        if ("Additional Discount $subTotalDiscountText".length < printer.printerNbrCharactersPerLine) {
//            text += "[L]Additional Discount [R]$subTotalDiscountText\n"
//        } else {
//            text += "[L]Additional [R]$subTotalDiscountText\n"
//            text += "[L]Discount\n"
//        }
//
//        if (receipt.additionalCosts.count() > 0){
//            text += "[C]--------------------------------\n"
//            text += "[L]Additional Cost\n"
//            for(i in receipt.additionalCosts){
//                var title = "Other Cost"
//                if(i.name == "delivery_fee"){
//                    title = "Delivery Fee"
//                }else if (i.name == "insurance"){
//                    title = "Insurance"
//                }
//                text += "[L]${title} [R]${CommonHelper.getRoundDoubleWithCurrency(i.cost, 2)}\n"
//            }
//        }
//
//        text += "[C]--------------------------------\n" +
//                "[L]Total [R]$totalAmountText\n"
//        if (saleInfo.note.isNotEmpty()) {
//            text += "[C]--------------------------------\n"
//            val note = StringUtils.wordWrap(saleInfo.note, POS_PRINTER_CHARACTER_PER_LINE_SMALL, "", Locale.getDefault())
//            text += "[L]Note\n" +
//                    "[L]<font size='small'>$note</font>\n"
//        }
//
//        text += "[C]--------------------------------\n" +
//                "[C]*** THANK YOU ***\n" +
//                "[L]\n"
//
//        return text
//    }
//}

//fun SunmiPrintHelper.printTicket(receipt: Receipt,
//                                 saleInfo: ReceiptSaleInfo,
//                                 bitmap: Bitmap?) {
//
//    print("-----------------------------------")
//    print(sunmiPrinterService)
//    if (sunmiPrinterService == null) {
//        return
//    }
//
//    try {
//        val posName = receipt.posName
//        val receiptNumber = receipt.saleNumber
//        val date = saleInfo.receiptDate
//
//        sunmiPrinterService.printerInit(null)
//        sunmiPrinterService.setAlignment(1, null)
//        sunmiPrinterService.printBitmap(bitmap, null)
//        sunmiPrinterService.lineWrap(1, null)
//        val storeName = StringUtils.wordWrap(saleInfo.storeName, PRINTER_CHARACTER_PER_LINE, "", Locale.getDefault())
//        printText("$storeName\n", PRINTER_FONT_SIZE_NORMAL, true, false)
//
//        val address = StringUtils.wordWrap(saleInfo.fullAddress, SUNMI_PRINTER_CHARACTER_PER_LINE_SMALL, "", Locale.getDefault())
//        printText("$address\n", PRINTER_FONT_SIZE_SMALL, false, false)
//        if (saleInfo.storePhoneNumber.isNotEmpty()) {
//            printText("${saleInfo.storePhoneNumber}\n", PRINTER_FONT_SIZE_SMALL, false, false)
//        }
//
//        printLine()
//        sunmiPrinterService.setAlignment(1, null)
//        sunmiPrinterService.printText("$posName\n", null)
//        printLine()
//
//        var width = intArrayOf(2, 1)
//        val align = intArrayOf(0, 2)
//        val txts = arrayOf("", "")
//
//        txts[0] = DateFormat.format("dd-MM-yyyy", date).toString()
//        txts[1] = DateFormat.format("HH:mm", date).toString()
//
//        sunmiPrinterService.setAlignment(0, null)
//        sunmiPrinterService.printColumnsString(txts, width, align, null)
//        sunmiPrinterService.printText("Ticket No: ${receiptNumber}\n", null)
//        sunmiPrinterService.printText("Cashier: ${saleInfo.employeeName}\n", null)
//        receipt.customerName?.let {customerName ->
//            sunmiPrinterService.printText("\n$customerName\n", null)
//        }
//        receipt.customerPhoneNumber?.let {phoneNumber ->
//            sunmiPrinterService.printText("$phoneNumber\n", null)
//        }
//
//        if (!receipt.diningOptionName.isNullOrEmpty()) {
//            sunmiPrinterService.printText("${receipt.diningOptionName}\n", null)
//        }
//
//        receipt.shippingAddress?.addressInfo?.let {
//            if (it.isNotEmpty()) {
//                val shapingAddress = StringUtils.wordWrap(it, PRINTER_CHARACTER_PER_LINE, "", Locale.getDefault())
//                sunmiPrinterService.printText("$shapingAddress\n", null)
//            }
//        }
//
//        printLine()
//        sunmiPrinterService.setAlignment(1, null)
//        sunmiPrinterService.printText("- Order Details -\n\n", null)
//
//        sunmiPrinterService.setAlignment(0, null)
//        receipt.items?.forEach { saleItem ->
//            var strPrice = CommonHelper.getRoundDoubleWithCurrency(saleItem.price, withCurrency = false)
//            val strQuantity = CommonHelper.roundDouble(saleItem.quantity)
//
//            var strAmount = CommonHelper.getRoundDoubleWithCurrency(saleItem.price * saleItem.quantity, withCurrency = false)
//            val strDiscount = if (saleItem.discountValue() > 0) {
//                "- ${CommonHelper.getRoundDoubleWithCurrency(saleItem.discountValue() * saleItem.quantity, withCurrency = false)}"
//            } else ""
//            val amountLengthLimit = maxOf(strDiscount.length, strAmount.length)
//            val itemNameLengthLimit = PRINTER_CHARACTER_PER_LINE - amountLengthLimit  - 1
//            val strName = StringUtils.wordWrap(saleItem.name, itemNameLengthLimit, "", Locale.getDefault())
//
//            val lines = strName.split("\n").toMutableList()
//
//            // Add variant name
//            if (saleItem.selectedVariantCombination != null) {
//                lines.add("(${saleItem.selectedVariantCombination?.value})")
//            }
//
//            lines.add("$strQuantity x $strPrice")
//
//            width = intArrayOf(itemNameLengthLimit, amountLengthLimit)
//            for ((index, value) in lines.withIndex()) {
//                if (index == 0) { // Name with amount
//                    txts[0] = value
//                    txts[1] = strAmount
//                    sunmiPrinterService.printColumnsString(txts, width, align, null)
//                } else if (index == 1) {  //Name with discount
//                    txts[0] = value
//                    txts[1] = strDiscount
//                    sunmiPrinterService.printColumnsString(txts, width, align, null)
//                } else {
//                    sunmiPrinterService.printText("$value\n", null)
//                }
//            }
//        }
//
//        printLine()
//
//        val subTotalDiscount = receipt.discounts?.sumByDouble {
//            if (it.discountType == Enums.DiscountType.PERCENTAGE.toString()) it.calculatedDiscount() else it.value } ?: 0.toDouble()
//        val itemsDiscount = receipt.discountedAmount - subTotalDiscount
//        val subTotalAmountText = CommonHelper.getRoundDoubleWithCurrency(receipt.grossAmount - receipt.additionalCosts.sumByDouble { it.cost }, 2)
//        val itemDiscountText = CommonHelper.getRoundDoubleWithCurrency(itemsDiscount, 2)
//        val subTotalDiscountText =  CommonHelper.getRoundDoubleWithCurrency(subTotalDiscount, 2)
//        val totalAmountText =  CommonHelper.getRoundDoubleWithCurrency(receipt.netAmount + receipt.additionalCosts.sumByDouble { it.cost }, 2)
//
//        width = intArrayOf(PRINTER_CHARACTER_PER_LINE - (subTotalAmountText.length + 1), subTotalAmountText.length + 1)
//
//        txts[0] = "Subtotal"
//        txts[1] = subTotalAmountText
//        width = intArrayOf(txts[0].length + 1, PRINTER_CHARACTER_PER_LINE - txts[0].length)
//        sunmiPrinterService.printColumnsString(txts, width, align, null)
//
//        txts[0] = "Discount"
//        txts[1] = itemDiscountText
//        width = intArrayOf(txts[0].length + 1, PRINTER_CHARACTER_PER_LINE - txts[0].length)
//        sunmiPrinterService.printColumnsString(txts, width, align, null)
//
//        txts[0] = "Additional Discount"
//        txts[1] = subTotalDiscountText
//        width = intArrayOf(txts[0].length + 1, PRINTER_CHARACTER_PER_LINE - txts[0].length)
//        sunmiPrinterService.printColumnsString(txts, width, align, null)
//
//        if(receipt.additionalCosts.count() > 0){
//            printLine()
//            sunmiPrinterService.printText("Additional Cost\n", null)
//            for(i in receipt.additionalCosts){
//                var title = "Cost"
//                if(i.name == "delivery_fee"){
//                    title = "Delivery Fee"
//                }else if (i.name == "insurance"){
//                    title = "Insurance"
//                }
//                txts[0] = title
//                txts[1] = "${i.cost}"
//                sunmiPrinterService.printColumnsString(txts, width, align, null)
//                printLine()
//            }
//        }
//
//        printLine()
//
//        txts[0] = "Total"
//        txts[1] = totalAmountText
//        width = intArrayOf(txts[0].length + 1, PRINTER_CHARACTER_PER_LINE - txts[0].length)
//        sunmiPrinterService.printColumnsString(txts, width, align, null)
//
//        printLine()
//
//        if (saleInfo.note.isNotEmpty()) {
//            sunmiPrinterService.printText("Note\n", null)
//            val note = StringUtils.wordWrap(saleInfo.note, SUNMI_PRINTER_CHARACTER_PER_LINE_SMALL, "", Locale.getDefault())
//            printText("$note\n", PRINTER_FONT_SIZE_SMALL, false, false)
//            printLine()
//        }
//
//        sunmiPrinterService.setAlignment(1, null)
//        sunmiPrinterService.printText("*** THANK YOU ***\n\n", null)
//
//        sunmiPrinterService.autoOutPaper(null)
//
//    } catch (e: RemoteException) {
//        Logger.e(e)
//    }
}