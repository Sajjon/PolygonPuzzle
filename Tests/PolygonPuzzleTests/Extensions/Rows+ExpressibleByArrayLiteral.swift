//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2020-07-03.
//

import Foundation
@testable import PolygonPuzzle

extension Rows.Row: ExpressibleByArrayLiteral {
    public typealias ArrayLiteralElement = Tile
    
    public init(arrayLiteral tiles: ArrayLiteralElement...) {
        self.init(tiles: tiles)
    }
    
    init(tiles: [Tile], index rowIndex: Int = 0) {
        let width = tiles.count
       
        let squares = tiles.enumerated().map {
            Square(
                columnIndex: $0.offset,
                rowIndex: rowIndex,
                tile: $0.element
            )
        }
        
        self.init(at: rowIndex, width: width, squares: squares)
    }
    
    init(repeating tile: Tile, count: Int, index: Int = 0) {
        self.init(tiles: .init(repeating: tile, count: count), index: index)
    }
}
