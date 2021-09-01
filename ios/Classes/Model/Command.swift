//
//  Command.swift
//  Pods-Runner
//
//  Created by Yoyo on 9/1/21.
//

import Foundation

struct Command: Codable {
    let blocks: [POSBlock]
    
    enum CodingKeys: String, CodingKey {
        case blocks
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        blocks = (try? container.decode([POSBlock].self, forKey: .blocks)) ?? []
    }
}
