//
//  Enum.swift
//  Pods-Runner
//
//  Created by Yoyo on 9/1/21.
//

import Foundation

enum POSCommandType: String, Codable {
    case text = "Text"
    case keyValue = "KeyValue"
    case linebreak = "Linebreak"
    case divider = "Divider"
    case image = "Image"
}

enum POSAlign: String, Codable {
    case left = "Left"
    case right = "Right"
    case center = "Center"
    
    var imageAlignValue: TicketImage.PredefinedAttribute {
        switch self {
        case .left: return .alignment(.left)
        case .center: return .alignment(.center)
        case .right: return .alignment(.right)
        }
    }
    
    var textAlignValue: Text.PredefinedAttribute {
        switch self {
        case .left: return .alignment(.left)
        case .center: return .alignment(.center)
        case .right: return .alignment(.right)
        }
    }
}

enum POSFont: String, Codable {
    case small = "Small"
    case medium = "Medium"
    case wide = "Wide"
    case tall = "Tall"
    case big = "Big"
    
    var fontValue: Text.PredefinedAttribute? {
        switch self {
        case .small: return .small
        default: return nil
        }
    }
}

enum POSFontWeight: String, Codable {
    case normal = "Normal"
    case bold = "Bold"
    
    var weightValue: Text.PredefinedAttribute? {
        switch self {
        case .bold: return .bold
        case .normal: return nil
        }
    }
}

enum POSUnderline: String, Codable {
    case none = "None"
    case single = "Single"
    case doubleStrike = "DoubleStrike"
}

enum POSWidth: String, Codable {
    case full = "Full"
    case half = "Half"
}
