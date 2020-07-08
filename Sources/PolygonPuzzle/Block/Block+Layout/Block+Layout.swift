//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2020-07-03.
//

import Foundation

public extension Block {
    typealias Layout =  [[Int]]
    
    static func layoutOfBlock(_ block: Self, rotationState: RotationState) -> Layout {
        block.rawLayout(rotationState: rotationState)
    }
    
    func rawLayout(rotationState: RotationState) -> Layout {
        switch self {
        case .iBlock:
            return Block.layoutOfBlockI(rotationState: rotationState)
        case .jBlock:
            return Block.layoutOfBlockJ(rotationState: rotationState)
        case .zBlock:
            return Block.layoutOfBlockZ(rotationState: rotationState)
        case .sBlock:
            return Block.layoutOfBlockS(rotationState: rotationState)
        case .tBlock:
            return Block.layoutOfBlockT(rotationState: rotationState)
        case .lBlock:
            return Block.layoutOfBlockL(rotationState: rotationState)
        case .oBlock:
            return Block.layoutOfBlockO(rotationState: rotationState)
        }
    }
}
