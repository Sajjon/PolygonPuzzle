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
        case .oBlock: return .oBlockFill
        case .iBlock: return .iBlockFill
        case .zBlock: return .zBlockFill
        case .sBlock: return .sBlockFill
        case .lBlock: return .lBlockFill
        case .jBlock: return .jBlockFill
        case .tBlock: return .tBlockFill
        }
    }
}
