//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2020-07-03.
//

import Foundation

public struct FallingPiece: SquaresRepresentable, Hashable {
    
    public let block: Block
    public let rotation: BlockRotation
    
    /// The size and coordinate of the bounding box of this falling piece.
    public internal(set) var abstractFrame: BoundingBox
    
    public init(
        block: Block,
        rotation: BlockRotation = .identity,
        coordinate: Coordinate? = nil
    ) {
        self.block = block
        self.rotation = rotation
        
        let size = block.size
        self.abstractFrame = .init(
            size: size,
            coordinate: coordinate ?? Coordinate.init(x: 0, y: -size.width)
        )
    }
}

public extension FallingPiece {
    init(
        block: Block,
        rotation: BlockRotation = .identity,
        column: Int
    ) {
        self.init(
            block: block,
            rotation: rotation,
            coordinate: .init(x: column, y: -block.size.width)
        )
    }
}
