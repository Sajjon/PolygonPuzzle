//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2020-07-03.
//

import Foundation

public extension FallingPiece {
    
    var leftMostFilledSquare: Square {
        guard let leftMostSquare = filledSquares.min(by: \.columnIndex) else {
            incorrectImplementation(shouldAlwaysBeAbleTo: "Get leftmost square")
        }
        return leftMostSquare
    }
    
    var rightMostFilledSquare: Square {
        guard let rightMostSquare = filledSquares.max(by: \.columnIndex) else {
            incorrectImplementation(shouldAlwaysBeAbleTo: "Get rightmost square")
        }
        return rightMostSquare
    }
    
    var bottomMostFilledSquare: Square {
        guard let bottomMostSquare = filledSquares.max(by: \.rowIndex) else {
            incorrectImplementation(shouldAlwaysBeAbleTo: "Get bottom most square")
        }
        return bottomMostSquare
    }
    
    var topMostFilledSquare: Square {
        guard let topMostFilledSquare = filledSquares.min(by: \.rowIndex) else {
            incorrectImplementation(shouldAlwaysBeAbleTo: "Get top most square")
        }
        return topMostFilledSquare
    }
    
    func squares(includeEmpty: Bool = true) -> [Square] {
        return includeEmpty ? allSquares : filledSquares
    }

    private var filledSquares: [Square] {
        allSquares.filter { $0.isFilled }
    }
    
    private var allSquares: [Square] {
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

