package com.tokoin.pos_printer.bluetooth_printer;

import com.dantsu.escposprinter.EscPosPrinterSize;
import com.dantsu.escposprinter.connection.DeviceConnection;

public class AsyncEscPosPrinter extends EscPosPrinterSize {
    private DeviceConnection printerConnection;
    private String textToPrint = "";

    public AsyncEscPosPrinter(DeviceConnection printerConnection, int printerDpi, float printerWidthMM, int printerNbrCharactersPerLine) {
        super(printerDpi, printerWidthMM, printerNbrCharactersPerLine);
        this.printerConnection = printerConnection;
    }

    public DeviceConnection getPrinterConnection() {
        return this.printerConnection;
    }

    public AsyncEscPosPrinter setTextToPrint(String textToPrint) {
        this.textToPrint = textToPrint;
        return this;
    }

    public String getTextToPrint() {
        return this.textToPrint;
    }

    public void reset() {
        textToPrint = "";
    }

    public void br() {
        textToPrint += "[C]--------------------------------\n";
    }

    public void linebreak(int num) {
        for (int i = 0; i < num; i++) {
            textToPrint +=  "[C]\n";
        }
    }

    public void linebreak() {
        textToPrint +=  "[C]\n";
    }

    public void text() {

    }
}
