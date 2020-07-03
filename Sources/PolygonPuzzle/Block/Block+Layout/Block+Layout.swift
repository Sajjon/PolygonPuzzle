//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2020-07-03.
//

import Foundation

public extension Block {
    typealias Layout =  [[Int]]
    
    static func layoutOfBlock(_ block: Self, rotation: BlockRotation) -> Layout {
        block.rawLayout(rotation: rotation)
    }
    
    func rawLayout(rotation: BlockRotation) -> Layout {
        switch self {
        case .iBlock:
            return Block.layoutOfBlockI(rotation: rotation)
        case .jBlock:
            return Block.layoutOfBlockJ(rotation: rotation)
        case .zBlock:
            return Block.layoutOfBlockZ(rotation: rotation)
        case .sBlock:
            return Block.layoutOfBlockS(rotation: rotation)
        case .tBlock:
            return Block.layoutOfBlockT(rotation: rotation)
        case .lBlock:
            return Block.layoutOfBlockL(rotation: rotation)
        case .oBlock:
            return Block.layoutOfBlockO(rotation: rotation)
        }
    }
}
