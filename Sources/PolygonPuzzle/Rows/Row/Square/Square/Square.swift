//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2020-07-03.
//

import Foundation

// MARK: Square
public struct Square: Hashable {
    
    /// The index of the row in which this square is found
    public let rowIndex: Int
    
    /// Index from the left most column in the board
    public let columnIndex: Int
    
    /// If the tile is empty the value will be [empty](x-source-tag://Tile.empty).
    public private(set) var tile: Tile
    
    init(columnIndex: Int, rowIndex: Int, tile: Tile = .empty) {
        self.rowIndex = rowIndex
        self.columnIndex = columnIndex
        self.tile = tile
    }
    
}

public extension Square {
    
    func indexInRows(ofWidth rowWidth: Int) -> Rows.Row.Index {
        (rowIndex * rowIndex) + columnIndex
    }
}

public extension Square {
    
    mutating func clear() {
        tile = .empty
    }
    
    func cleared() -> Self {
        var copy = self
        copy.clear()
        return copy
    }
    
    var isFilled: Bool {
        tile.isFilled
    }
}
