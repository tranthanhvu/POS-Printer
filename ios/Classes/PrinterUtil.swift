//
//  PrinterUtil.swift
//  Pods-Runner
//
//  Created by Yoyo on 9/1/21.
//

import Foundation
import CoreGraphics
import UIKit

class PrinterUtil {
    static func testPrint() {
        let json = "[{\"blocks\":[{\"content\": \"RECEIPT\"}]}]"
        
        printReceiptJSON(commandsJSON: json)
    }
    
    static func printReceiptJSON(commandsJSON: String) {
        if let data = commandsJSON.data(using: .utf8) {
            do {
                let commands = try JSONDecoder().decode([Command].self, from: data)
                
                printReceipt(commands: commands)
            } catch {
                print(error)
            }
        }
    }
    
    static func printReceipt(commands: [Command]) {
        let bluetoothPrinterManager = SwiftPosPrinterPlugin.bluetoothPrinterManager
        
        if bluetoothPrinterManager.canPrint {
            printReceipt(bluetoothPrinterManager: bluetoothPrinterManager, commands: commands)
        } else {
            if let root = UIApplication.shared.keyWindow?.rootViewController {
                let vc = BluetoothPrinterSelectTableViewController()
                vc.printerManager = bluetoothPrinterManager
                
                let nv = UINavigationController(rootViewController: vc)
                
                root.present(nv, animated: true)
            }
        }
    }
    
    static private func printReceipt(bluetoothPrinterManager: BluetoothPrinterManager, commands: [Command]) {
        
        var ticket = Ticket()
        ticket.feedLinesOnHead = 1
        
        for command in commands {
            var textBlocks: [POSBlock] = []
            
            for block in command.blocks {
                switch block.type {
                case .text:
                    textBlocks.append(block)
                case .image:
                    let image = block.content.imageFromBase64()
                    if let scaledImage = image?.resizeWithWidth(width: CGFloat(PRINTER_DENSITY)) {
                        ticket.add(block: .image(scaledImage, attributes: block.align.imageAlignValue))
                    }
                    
                case .divider:
                    if command.blocks.count == 1 {
                        ticket.add(block: .dividing)
                    }
                case .linebreak:
                    if command.blocks.count == 1 {
                        ticket.add(block: .blank)
                    }
                    
                }
            }
            
            if (textBlocks.count == 1) {
                let block = textBlocks.first!
                var predefined: [Text.PredefinedAttribute] = [block.align.textAlignValue]
                
                if let font = block.font.fontValue {
                    predefined.append(font)
                }
                
                if let weight = block.fontWeight.weightValue {
                    predefined.append(weight)
                }
                
                ticket.add(block: .text(.init(content: block.content, predefined: predefined)))
            } else if (textBlocks.count == 2) {
                let keyBlock = textBlocks.first!
                let valueBlock = textBlocks.first!
                ticket.add(block: .kv(k: keyBlock.content, v: valueBlock.content))
            }
        }
        
        if bluetoothPrinterManager.canPrint {
            bluetoothPrinterManager.print(ticket)
        }
    }
}
