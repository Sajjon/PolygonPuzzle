//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2020-07-03.
//

import Foundation

public struct FallingPiece {
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
    struct BoundingBox {
        public let size: Size
        
        /// Coordinate of the top left corner of this bounding box
        fileprivate var coordinate: Coordinate
    }
}

public extension FallingPiece {
    
    var size: Size {
        abstractFrame.size
    }
    
    var width: Size.Value {
        size.width
    }
    
    var height: Size.Value {
        size.height
    }
    
    var coordinateOfTopLeftCornerOfBoundingBox: Coordinate {
        abstractFrame.coordinate
    }
    
    var coordinateOfBottomRightCornerOfBoundingBox: Coordinate {
        .init(
            x: coordinateOfTopLeftCornerOfBoundingBox.x + width-1,
            y: coordinateOfTopLeftCornerOfBoundingBox.y + height-1
        )
    }
}

private extension FallingPiece {
    enum Movement {
        case left, right, down
    }
    
    mutating func move(_ movement: Movement, amount: Int = 1) {
        switch movement {
        case .left: abstractFrame.coordinate.x -= amount
        case .right: abstractFrame.coordinate.x += amount
        case .down: abstractFrame.coordinate.y += amount
        }
    }
}

public extension FallingPiece {
    
    enum Error: Swift.Error {
        case cannotMoveLeftIsAtEdge
    }
    
    mutating func moveDown() {
        move(.down)
    }
    
    mutating func moveLeft() throws {
        guard coordinateOfTopLeftCornerOfBoundingBox.x > 0 else {
            throw Error.cannotMoveLeftIsAtEdge
        }
        move(.left)
    }
    
    mutating func moveRight() {
        move(.right)
    }
}

public extension FallingPiece {
    var filledSquares: [Square] {
        Self.squaresWithInternalLayout(block: block, rotation: rotation).flatMap { row in
            row.map { layoutSquare in
                Square(
                    columnIndex: layoutSquare.relativeCoordinate.x + abstractFrame.coordinate.x,
                    rowIndex: layoutSquare.relativeCoordinate.y + abstractFrame.coordinate.y,
                    tile: layoutSquare.tile
                )
            }
        }
    }
    
    struct LayingOutSquare {
        let relativeCoordinate: Coordinate
        let tile: Tile
    }
    
    static func squaresWithInternalLayout(
        block: Block,
        rotation: BlockRotation
    ) -> [[LayingOutSquare]] {
        let rawLayout: [[Int]] = block.rawLayout(rotation: rotation)
        
        let tileFromRaw: (Int) -> Tile = {
            guard $0 != 0 else { return .empty }
            return .filled(block.fill)
        }
        
        return rawLayout.enumerated().map { (rowIndex, row) in
            row.enumerated().map { (columnIndex, rawTile) in
                LayingOutSquare(
                    relativeCoordinate: .init(x: columnIndex, y: rowIndex),
                    tile: tileFromRaw(rawTile)
                )
            }
            
        }
    }
}

