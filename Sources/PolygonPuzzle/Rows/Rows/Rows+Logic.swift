//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2020-07-03.
//

import Foundation

public extension Rows {
    
    enum InlayPieceError: Swift.Error, Equatable {
        case squaresOverlap
    }
    
    enum Prediction: Equatable {
        case pieceNotInFrame
        case noCollision(distancePerColumnInPiece: [Int])
        case collision(numberOfRowsCleared: Int)
    }
    
    subscript(coordinate: Coordinate) -> Square {
        get { self[coordinate.row][coordinate.column] }
        set { self[coordinate.row][coordinate.column] = newValue }
    }
    
    static func reduce(
        state rows: Self,
        inlaying piece: FallingPiece
    ) -> Result<Prediction, InlayPieceError> {
        precondition(piece.bottomMostFilledSquare.rowIndex <= rows.bottomMostRowIndex, "Piece should not be below last row")
        precondition(piece.leftMostFilledSquare.columnIndex >= 0, "Piece should not be outside of left edge")
        precondition(piece.rightMostFilledSquare.columnIndex <= rows.rowWidth, "Piece should not be outside of right edge")
        for row in rows {
            precondition(row.isFilled == false, "All rows should be non-filled")
        }
        
        
        guard
            case let pieceCompletelyInFrame =  piece.topMostFilledSquare.rowIndex >= 0,
            pieceCompletelyInFrame
        else {
            return .success(.pieceNotInFrame)
        }
        
        
        for pieceSquare in piece.filledSquares {
            guard rows[pieceSquare.coordinate].isEmpty else {
                return .failure(.squaresOverlap)
            }
        }
        
        var collisionDistancePerColumn: [Int: Int] = [:]
        for bottomMostSquarePerColumn in piece.bottomMostFilledSquaresPerColumn {
            let columnIndex = bottomMostSquarePerColumn.columnIndex
            let collisionDistance: Int
            if let topMostSquareInRowsInColumn = rows.topMostFilledSquareInColumn(columnIndex) {
                collisionDistance = topMostSquareInRowsInColumn.rowIndex - bottomMostSquarePerColumn.rowIndex
            } else {
                collisionDistance = rows.height - bottomMostSquarePerColumn.rowIndex
            }
            collisionDistancePerColumn[columnIndex] = collisionDistance
        }
        
        let minimumCollisionDistanceWithColumnIndex = collisionDistancePerColumn.min(by: { $0.value < $1.value })!
        
        let isColliding = minimumCollisionDistanceWithColumnIndex.value == 0
        
        guard isColliding else {
            return .success(.noCollision(distancePerColumnInPiece: collisionDistancePerColumn.values.map { $0 }))
        }
        
        // Check if we can clear any rows!
        var inlayedRows = rows
        for pieceSquare in piece.filledSquares {
            inlayedRows[pieceSquare.coordinate] = pieceSquare
        }
        
        let numberOfFilledRows = inlayedRows.filter { $0.isFilled }.count
        
        return .success(.collision(numberOfRowsCleared: numberOfFilledRows))
    }
 
}

public struct Column: Hashable {
    
    let squares: [Square]
    
    init(squares: [Square]) {
        guard let firstRowSquare = squares.first else {
            incorrectImplementation(shouldAlwaysBeAbleTo: "Get square at first row in column")
        }
        var previousRowIndex = -1
        for square in squares {
            assert(square.columnIndex == firstRowSquare.columnIndex)
            let rowIndex = square.rowIndex
            defer {
                previousRowIndex = rowIndex
            }
            assert(rowIndex == (previousRowIndex + 1))
        }
        
        self.squares = squares
    }
}
