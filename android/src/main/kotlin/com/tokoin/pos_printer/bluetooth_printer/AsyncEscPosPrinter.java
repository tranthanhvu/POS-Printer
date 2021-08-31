package com.tokoin.pos_printer.bluetooth_printer;

import com.dantsu.escposprinter.EscPosPrinterSize;
import com.dantsu.escposprinter.connection.DeviceConnection;
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

    public String getTextToPrint() {
        StringBuilder textToPrint = new StringBuilder();

        for (int i = 0; i < commandList.size(); i++) {
            Command command = commandList.get(i);
            StringBuilder commandStr = new StringBuilder();

            if (command.getBlocks() == null) {
                continue;
            }

            for (int j = 0; j < command.getBlocks().size(); j++) {
                Block block = command.getBlocks().get(j);
                String blockStr = "";

                switch (block.getType()) {
                    case text:
                        blockStr = textBlockToString(block);
                        break;

                    case image:
                        blockStr = imageBlockToString(block);
                        break;

                    case divider:
                        blockStr = dividerBlockToString();
                        break;

                    case linebreak:
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
            case small:
                blockStr = "<font size='normal'>" + block.getContent() + "</font>";
                break;

            case medium:
                blockStr = block.getContent();
                break;

            case tall:
                blockStr = "<font size='tall'>" + block.getContent() + "</font>";
                break;

            case wide:
                blockStr = "<font size='wide'>" + block.getContent() + "</font>";
                break;

            case big:
                blockStr = "<font size='big'>" + block.getContent() + "</font>";
                break;
        }


        switch (block.getFontWeight()) {
            case bold:
                blockStr = "<b>" + blockStr + "</b>";
                break;

            case normal:
                break;
        }


        switch (block.getUnderline()) {
            case none:
                break;

            case single:
                blockStr = "<u>" + blockStr + "</u>";
                break;

            case doubleStrike:
                blockStr = "<u type='double'>" + blockStr + "</u>";
                break;
        }


        switch (block.getAlign()) {
            case left:
                blockStr = "[L]" + blockStr;
                break;

            case right:
                blockStr = "[R]" + blockStr;
                break;

            case center:
                blockStr = "[C]" + blockStr;
                break;
        }

        return blockStr;
    }

    private String imageBlockToString(Block block) {
        String blockStr = "<img>" + block.getContent() + "</img>";

        switch (block.getAlign()) {
            case left:
                blockStr = "[L]" + blockStr;
                break;

            case right:
                blockStr = "[R]" + blockStr;
                break;

            case center:
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
