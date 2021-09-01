//
//  POSBlock.swift
//  Pods-Runner
//
//  Created by Yoyo on 9/1/21.
//

import Foundation

struct POSBlock: Codable {
    let content: String
    let type: POSType
    let align: POSAlign
    let font: POSFont
    let fontWeight: POSFontWeight
    let underline: POSUnderline
    let columnWidth: POSWidth
    
    enum CodingKeys: String, CodingKey {
        case content
        case type
        case align
        case font
        case fontWeight = "weight"
        case underline
        case columnWidth = "width"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        content = (try? container.decode(String.self, forKey: .content)) ?? ""
        type = (try? container.decode(POSType.self, forKey: .type)) ?? .text
        align = (try? container.decode(POSAlign.self, forKey: .align)) ?? .left
        font = (try? container.decode(POSFont.self, forKey: .font)) ?? .medium
        fontWeight = (try? container.decode(POSFontWeight.self, forKey: .fontWeight)) ?? .normal
        underline = (try? container.decode(POSUnderline.self, forKey: .underline)) ?? .none
        columnWidth = (try? container.decode(POSWidth.self, forKey : .columnWidth)) ?? .full
    }
}
