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
    
    enum RowsReduction: Equatable {
        case pieceNotInFrame
        case noContact(distancePerColumnInPiece: [Int])
        
        public enum Contact: Equatable {
            case noFilledRows(rowsAfterContact: Rows)
            
            case didFillAndClearRows(
                    collidedRowsBeforeBeingCleared: Rows,
                    rowsAfterBeingCleared: Rows,
                    numberOfRowsCleared: Int
                 )
            
        }
        
        case contact(Contact)
    }
    
    subscript(coordinate: Coordinate) -> Square {
        get { self[coordinate.row][coordinate.column] }
        set { self[coordinate.row][coordinate.column] = newValue }
    }
    
    mutating func reduce(inlaying piece: FallingPiece) {
        do {
            let rowsReduction = try Self.reduce(state: self, inlaying: piece).get()
            switch rowsReduction {
            
            case .pieceNotInFrame:
                print("piece not in frame")
                
            case .noContact(let distancePerColumnInPiece):
                print("No contact, distances per column of piece: \(distancePerColumnInPiece)")
           
            case .contact(let contact):
                switch contact {
                
                case .noFilledRows(let rowsAfterContact):
                    print("contact, but did not clear fill any rows")
                    self = rowsAfterContact
                    
                case .didFillAndClearRows(
                        let collidedRowsBeforeBeingCleared,
                        let rowsAfterBeingCleared,
                    let numberOfRowsCleared
                ):
                print("contact: #rows to clear: \(numberOfRowsCleared)")
                self = rowsAfterBeingCleared
                }
            }
        } catch {
            print("error reducing rows: \(error)")
        }
    }
    
    static func reduce(
        state rows: Self,
        inlaying piece: FallingPiece
    ) -> Result<RowsReduction, InlayPieceError> {
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
        
        let willMakeContact = minimumCollisionDistanceWithColumnIndex.value <= 1
        
        guard willMakeContact else {
            return .success(
                .noContact(distancePerColumnInPiece: collisionDistancePerColumn.values.map { $0 })
            )
        }
        
        // Check if we can clear any rows!
        var inlayedRows = rows
        for pieceSquare in piece.filledSquares {
            inlayedRows[pieceSquare.coordinate] = pieceSquare
        }
        
        let numberOfFilledRows = inlayedRows.filter { $0.isFilled }.map { $0.index }.count
        
        guard numberOfFilledRows > 0 else {
            return .success(.contact(.noFilledRows(rowsAfterContact: inlayedRows)))
        }
        
        var nonFilledRows = inlayedRows.filter { !$0.isFilled }
        
        var nonFilledRowsFromBottomUp = [Row]()
        while let row = nonFilledRows.popLast() {
            let rowIndex = rows.bottomMostRowIndex - nonFilledRowsFromBottomUp.count
            let translatedRow = Row(
                at: rowIndex,
                width: row.width,
                squares: row.map { square in
                    Square(
                        columnIndex: square.columnIndex,
                        rowIndex: rowIndex,
                        tile: square.tile
                    )
                }
            )
            
            nonFilledRowsFromBottomUp.append(translatedRow)
        }
        
        for _ in 0..<(rows.height - nonFilledRowsFromBottomUp.count) {
            let rowIndex = rows.bottomMostRowIndex - nonFilledRowsFromBottomUp.count
            let emptyRow = Row(at: rowIndex, width: rows.rowWidth)
            nonFilledRowsFromBottomUp.append(emptyRow)
        }
        
        let clearedRows = Rows(rows: nonFilledRowsFromBottomUp.reversed())
        
        assert(clearedRows.height == rows.height)
        
        clearedRows.forEach { row in
            assert(!row.isFilled)
        }
        
        return .success(
            .contact(
                .didFillAndClearRows(
                    collidedRowsBeforeBeingCleared: inlayedRows,
                    rowsAfterBeingCleared: clearedRows,
                    numberOfRowsCleared: numberOfFilledRows
                )
            )
        )
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
