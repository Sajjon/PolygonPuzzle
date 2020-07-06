//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2020-07-03.
//

import Foundation
@testable import PolygonPuzzle

extension Row: ExpressibleByArrayLiteral {
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

extension Rows: ExpressibleByStringLiteral {
    public typealias StringLiteralType = String
    public init(stringLiteral rowsAsString: StringLiteralType) {
        
        let rowStrings = rowsAsString
            .split(separator: "\n")
            .map {
                String($0)
                    .trimmingCharacters(in: .whitespacesAndNewlines)
                    .replacingOccurrences(of: " ", with: "")
            }
        
        self.init(rowsWithoutIndices: rowStrings.map { Row(stringLiteral: $0) })
    }
}


extension Row: ExpressibleByStringLiteral {
    public typealias StringLiteralType = String
    public init(stringLiteral rowAsString: StringLiteralType) {
        self.init(tiles: rowAsString.map { Tile(stringLiteral: String($0)) })
    }
}

extension Tile: ExpressibleByStringLiteral {
    public typealias StringLiteralType = String
    public init(stringLiteral value: StringLiteralType) {
        if value == "🤍" {
            self = .empty
        } else {
            self = .filled(Fill(stringLiteral: value))
        }
    }
}


extension Tile.Fill: ExpressibleByStringLiteral {
    public typealias StringLiteralType = String
    public init(stringLiteral value: StringLiteralType) {
        let fillColor = FillColor(stringLiteral: value)
        self = Self(ofColor: fillColor)
    }
}

extension Tile.Fill.FillColor: ExpressibleByStringLiteral {
    public typealias StringLiteralType = String
    public init(stringLiteral value: StringLiteralType) {
        switch value {
        case "💛": self = .yellow
        case "🤎": self = .teal // for lack of teal colored heart
        case "❤️": self = .red
        case "💚": self = .green
        case "🧡": self = .orange
        case "💙": self = .blue
        case "💜": self = .purple
        default: incorrectImplementation(reason: "Incorrect string literal for fillcolor: \(value)")
        }
    }
}
