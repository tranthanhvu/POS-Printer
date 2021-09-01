package com.tokoin.pos_printer.bluetooth_printer;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.util.Base64;
import android.util.Log;

import com.dantsu.escposprinter.EscPosPrinterSize;
import com.dantsu.escposprinter.connection.DeviceConnection;
import com.dantsu.escposprinter.textparser.PrinterTextParserImg;
import com.tokoin.pos_printer.model.Block;
import com.tokoin.pos_printer.model.Command;

import java.util.List;

public class AsyncEscPosPrinter extends EscPosPrinterSize {
    private final DeviceConnection printerConnection;
    private List<Command> commandList;

    public AsyncEscPosPrinter(DeviceConnection printerConnection, int printerDpi, float printerWidthMM, int printerNbrCharactersPerLine) {
        super(printerDpi, printerWidthMM, printerNbrCharactersPerLine);
        this.printerConnection = printerConnection;
    }

    public DeviceConnection getPrinterConnection() {
        return this.printerConnection;
    }

    public AsyncEscPosPrinter setCommands(List<Command> commands) {
        this.commandList = commands;
        return this;
    }

    public List<Command> getCommands() {
        return this.commandList;
    }

    public String getTextToPrint() {
        StringBuilder textToPrint = new StringBuilder();

        for (int i = 0; i < commandList.size(); i++) {
            Command command = commandList.get(i);
            StringBuilder commandStr = new StringBuilder();

            for (int j = 0; j < command.getBlocks().size(); j++) {
                Block block = command.getBlocks().get(j);
                String blockStr = "";

                switch (block.getType()) {
                    case Text:
                        blockStr = textBlockToString(block);
                        break;

                    case Image:
                        blockStr = imageBlockToString(block);
                        break;

                    case Divider:
                        blockStr = dividerBlockToString();
                        break;

                    case Linebreak:
                        blockStr = "\n";
                        break;
                }

                commandStr.append(blockStr);
            }

            textToPrint.append(commandStr.toString());
        }

        return textToPrint.toString();
    }

    private String textBlockToString(Block block) {
        String blockStr = "";

        if (block.getContent().isEmpty() || block.getContent().equals("\n")) {
            return  block.getContent();
        }

        switch (block.getFont()) {
            case Small:
                blockStr = "<font size='normal'>" + block.getContent() + "</font>";
                break;

            case Medium:
                blockStr = block.getContent();
                break;

            case Tall:
                blockStr = "<font size='tall'>" + block.getContent() + "</font>";
                break;

            case Wide:
                blockStr = "<font size='wide'>" + block.getContent() + "</font>";
                break;

            case Big:
                blockStr = "<font size='big'>" + block.getContent() + "</font>";
                break;
        }


        switch (block.getFontWeight()) {
            case Bold:
                blockStr = "<b>" + blockStr + "</b>";
                break;

            case Normal:
                break;
        }


        switch (block.getUnderline()) {
            case None:
                break;

            case Single:
                blockStr = "<u>" + blockStr + "</u>";
                break;

            case DoubleStrike:
                blockStr = "<u type='double'>" + blockStr + "</u>";
                break;
        }


        switch (block.getAlign()) {
            case Left:
                blockStr = "[L]" + blockStr;
                break;

            case Right:
                blockStr = "[R]" + blockStr;
                break;

            case Center:
                blockStr = "[C]" + blockStr;
                break;
        }

        return blockStr;
    }

    private String imageBlockToString(Block block) {
        byte[] bytes = Base64.decode(block.getContent(), Base64.DEFAULT);
        Bitmap bitmap = BitmapFactory.decodeByteArray(bytes, 0, bytes.length);
        String imgContent = PrinterTextParserImg.bitmapToHexadecimalString(this, bitmap);
        String blockStr = "<img>" + imgContent + "</img>";

        switch (block.getAlign()) {
            case Left:
                blockStr = "[L]" + blockStr;
                break;

            case Right:
                blockStr = "[R]" + blockStr;
                break;

            case Center:
                blockStr = "[C]" + blockStr;
                break;
        }

        return blockStr;
    }

    private String dividerBlockToString() {
        StringBuilder blockStr = new StringBuilder("[C]");

        for (int i = 0; i < printerNbrCharactersPerLine; i++) {
            blockStr.append("-");
        }

        return blockStr.toString();
    }
}
