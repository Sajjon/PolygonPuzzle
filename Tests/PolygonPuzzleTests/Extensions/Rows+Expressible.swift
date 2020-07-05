//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2020-07-05.
//

import Foundation
@testable import PolygonPuzzle

// MARK: ExpressibleByArrayLiteral
extension Rows: ExpressibleByArrayLiteral {
    public typealias ArrayLiteralElement = Row
    public init(arrayLiteral rows: Row...) {
        var rowIndex = 0
        self.init(
            rows: rows.map { row in
                defer { rowIndex += 1 }
                return Row(
                    at: rowIndex,
                    width: row.width,
                    squares: row.squares.map { square in
                        Square(
                            columnIndex: square.columnIndex,
                            rowIndex: rowIndex,
                            tile: square.tile
                        )
                    }
                )
            }
        )
    }
}
