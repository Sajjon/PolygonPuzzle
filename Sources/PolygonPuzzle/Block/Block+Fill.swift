//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2020-07-03.
//

import Foundation

public extension Block {
    var fill: Tile.Fill {
        switch self {
        case .oBlock: return .yellow
        case .iBlock: return .teal
        case .zBlock: return .red
        case .sBlock: return .green
        case .lBlock: return .orange
        case .jBlock: return .blue
        case .tBlock: return .purple
        }
    }
}
