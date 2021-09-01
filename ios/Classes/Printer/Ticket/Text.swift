//
//  TextBlock.swift
//  Ticket
//
//  Created by gix on 2019/6/30.
//  Copyright © 2019 gix. All rights reserved.
//

import Foundation
import UIKit

public struct Text: BlockDataProvider {
    
    let content: String
    let attributes: [Attribute]?
    
    public init(_ content: String, attributes: [Attribute]? = nil) {
        self.content = content
        self.attributes = attributes
    }
    
    public func data(using encoding: String.Encoding) -> Data {
        var result = Data()
        
        if let attrs = attributes {
            result.append(Data(attrs.flatMap { $0.attribute }))
        }
        
        if let cd = content.data(using: encoding) {
            result.append(cd)
        }
        
        return result
    }
}

public extension Text {
    
    enum PredefinedAttribute: Attribute {
        
        public enum ScaleLevel: UInt8 {
            
            case l0 = 0x00
            case l1 = 0x01
            case l2 = 0x10
            case l3 = 0x11
            case l4 = 0x20
            case l5 = 0x21
            case l6 = 0x22
            
        }
        
        case alignment(NSTextAlignment)
        case bold
        case small
        case light
        case scale(ScaleLevel)
        case feed(UInt8)
        
        public var attribute: [UInt8] {
            switch self {
            case let .alignment(v):
                return ESC_POSCommand.justification(v == .left ? 0 : v == .center ? 1 : 2).rawValue
            case .bold:
                return ESC_POSCommand.emphasize(mode: true).rawValue
            case .small:
                return ESC_POSCommand.font(1).rawValue
            case .light:
                return ESC_POSCommand.color(n: 1).rawValue
            case let .scale(v):
                return [0x1D, 0x21, v.rawValue]
            case let .feed(v):
                return ESC_POSCommand.feed(points: v).rawValue
            }
        }
    }
}

public extension Text {
    
    init(content: String, predefined attributes: [PredefinedAttribute]) {
        self.init(content, attributes: attributes)
    }
}

public extension Text {
    
    static func title(_ content: String) -> Text {
        let lines = content.splitToLinesWrapWordBy(length: PRINT_TEXT_NORMAL_LENGTH)
        return Text(content: lines.joined(separator: "\n"), predefined: [.scale(.l1), .alignment(.center)])
    }
    
    static func kv(k: String, v: String, attributes: [Attribute]? = nil) -> Text {
        
        var num = PRINT_TEXT_NORMAL_LENGTH
        
        let string = k + v
        if string.count < num - 1 {
            for c in string {
                if (c >= "\u{2E80}" && c <= "\u{FE4F}") || c == "\u{FFE5}"{
                    num -= 2
                } else  {
                    num -= 1
                }
            }
            
            var contents = stride(from: 0, to: num, by: 1).map { _ in " " }
            
            contents.insert(k, at: 0)
            contents.append(v)
            
            return Text(contents.joined(), attributes: attributes)
            
        } else {  // length exeed the printee
            var lines = k.splitToLinesWrapWordBy(length: num - v.count - 1)
            let spaces = String(repeating: " ", count: num - v.count - lines[0].count)
            lines[0].append("\(spaces)\(v)")
            
            return Text(lines.joined(separator: "\n"), attributes: attributes)
        }
    }
    
    static func wrapText(content: String,
                         length: Int = PRINT_TEXT_NORMAL_LENGTH,
                         predefined attributes: [PredefinedAttribute]) -> Text {
        
        let lines = content.splitToLinesWrapWordBy(length: length)
        
        return Text(lines.joined(separator: "\n"), attributes: attributes)
    }
}

