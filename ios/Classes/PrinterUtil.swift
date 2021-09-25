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
        
//        testProgress(bluetoothPrinterManager: bluetoothPrinterManager, commands: commands)
        
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
        
        let ticket = PrinterUtil.ticket(from: commands)
        
        if bluetoothPrinterManager.canPrint {
            bluetoothPrinterManager.print(ticket, progressBlock: { progress in
                ProgressBarViewController.default.setProgress(progress)
            }, completeBlock: { error in
                handleError(error)
            })
        }
    }
    
    static private func testProgress(bluetoothPrinterManager: BluetoothPrinterManager, commands: [Command]) {
        
        let ticket = PrinterUtil.ticket(from: commands)
        
        bluetoothPrinterManager.testProgressView(ticket, progressBlock: { progress in
            ProgressBarViewController.default.setProgress(progress)
        }, completeBlock: { error in
            handleError(error)
        })
    }
    
    static private func handleError(_ error: PError?) {
        if let error = error {
            switch error {
            case .connectFailed:
                showMessage(title: "Broken connection", message: "Unable to connect the printer.")
            case .deviceNotReady:
                showMessage(title: "Failure", message: "The printer is not ready.")
            }
            return
        }
        
        if (ProgressBarViewController.default.presentingViewController != nil) {
            ProgressBarViewController.default.completeBlock = {
                showMessage(title: "Success", message: "The ticket is printed!")
            }
        } else {
            showMessage(title: "Success", message: "The ticket is printed!")
        }
    }
    
    static private func showMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        
        if let root = UIApplication.shared.keyWindow?.rootViewController {
            root.present(alert, animated: true)
        }
    }
    
    static private func ticket(from commands: [Command]) -> Ticket {
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
        
        return ticket
    }
}
