//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2020-07-03.
//

import Foundation

// MARK:  SquaresRepresentable
public extension FallingPiece {
    
    func rowAtIndex(_ rowIndex: Int) -> Row {
        let squaresAtRow = squares.filter { $0.rowIndex == rowIndex }
        guard !squaresAtRow.isEmpty else {
            incorrectImplementation(shouldAlwaysBeAbleTo: "Get squares at row by index")
        }
        return Row(
            at: rowIndex,
            width: squaresAtRow[0].rowIndex,
            squares: squaresAtRow
        )
    }
    
    var squares: [Square] {
        Self.squaresWithInternalLayout(block: block, rotationState: rotationState).flatMap { row in
            row.map { layoutSquare in
                Square(
                    columnIndex: layoutSquare.relativeCoordinate.x + abstractFrame.coordinate.x,
                    rowIndex: layoutSquare.relativeCoordinate.y + abstractFrame.coordinate.y,
                    tile: layoutSquare.tile
                )
            }
        }
    }
}

// MARK: Internal Layout
public extension FallingPiece {
    struct LayingOutSquare {
        let relativeCoordinate: Coordinate
        let tile: Tile
    }
    
    static func squaresWithInternalLayout(
        block: Block,
        rotationState: RotationState
    ) -> [[LayingOutSquare]] {
        let rawLayout: [[Int]] = block.rawLayout(rotationState: rotationState)
        
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

