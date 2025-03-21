//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2020-07-03.
//

import Foundation

public struct FallingPiece: SquaresRepresentable, Hashable {
    
    public let block: Block
    public let rotationState: RotationState
    
    /// The size and coordinate of the bounding box of this falling piece.
    public internal(set) var abstractFrame: BoundingBox
    
    public init(
        block: Block,
        rotationState: RotationState = .identity,
        coordinate: Coordinate? = nil
    ) {
        self.block = block
        self.rotationState = rotationState
        
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
        rotationState: RotationState = .identity,
        centerInColumn: Int
    ) {
        self.init(
            block: block,
            rotationState: rotationState,
            coordinate: .init(
                x: centerInColumn - block.size.width/2,
                y: -block.size.height
            )
        )
    }
}
