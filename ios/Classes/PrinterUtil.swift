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
            switch command.type {
            case .text:
                if (command.blocks.count == 1) {
                    let block = command.blocks.first!
                    var predefined: [Text.PredefinedAttribute] = [block.align.textAlignValue]
                    
                    if let font = block.font.fontValue {
                        predefined.append(font)
                    }
                    
                    if let weight = block.fontWeight.weightValue {
                        predefined.append(weight)
                    }
                    
                    ticket.add(block: .text(.init(content: block.content, predefined: predefined)))
                }
                
            case .keyValue:
                if (command.blocks.count == 2) {
                    let keyBlock = command.blocks.first!
                    let valueBlock = command.blocks.last!
                    ticket.add(block: .kv(k: keyBlock.content, v: valueBlock.content))
                }
                
            case .image:
                if (command.blocks.count == 1) {
                    let block = command.blocks.first!
                    let image = block.content.imageFromBase64()
                    if let scaledImage = image?.resizeWithWidth(width: CGFloat(PRINTER_DENSITY)) {
                        ticket.add(block: .image(scaledImage, attributes: block.align.imageAlignValue))
                    }
                }
                
            case .divider:
                ticket.add(block: .dividing)
                
            case .linebreak:
                ticket.add(block: .blank)
            }
        }
        
        if bluetoothPrinterManager.canPrint {
            bluetoothPrinterManager.print(ticket)
        }
    }
}
