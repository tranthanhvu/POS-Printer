//
//  Command.swift
//  Pods-Runner
//
//  Created by Yoyo on 9/1/21.
//

import Foundation

struct Command: Codable {
    let blocks: [POSBlock]
    let type: POSCommandType
    
    enum CodingKeys: String, CodingKey {
        case blocks
        case type
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        blocks = (try? container.decode([POSBlock].self, forKey: .blocks)) ?? []
        type = (try? container.decode(POSCommandType.self, forKey: .type)) ?? .text
    }
}
