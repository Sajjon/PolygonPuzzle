//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2020-07-03.
//

import Foundation

// MARK: Tile
public enum Tile: Hashable, ExpressibleByIntegerLiteral {
    
    /// Nothing occupies this tile.
    ///
    /// - Tag: Tile.empty
    case empty
    
    case filled(Fill)
}

public extension Tile {
    var isFilled: Bool {
        guard case .filled = self else {
            return false
        }
        return true
    }
    
    static func filledWith(color: Fill.FillColor) -> Self {
        let fill = Tile.Fill(ofColor: color)
        return .filled(fill)
    }
    
    static let yellow = Self.filledWith(color: .yellow)
    static let teal = Self.filledWith(color: .teal)
    static let red = Self.filledWith(color: .red)
    static let green = Self.filledWith(color: .green)
    static let orange = Self.filledWith(color: .orange)
    static let blue = Self.filledWith(color: .blue)
    static let purple = Self.filledWith(color: .purple)
    
    init(integerLiteral value: Int) {
        precondition(value >= 0)
        precondition(value <= Tile.Fill.maxRawValue)
        if value == 0 {
            self = .empty
        } else {
            guard let fill = Fill(rawValue: value) else {
                incorrectImplementation(reason: "Bad literal passed in: \(value), max value is: \(Tile.Fill.maxRawValue)")
            }
            self = .filled(fill)
        }
    }
    
}

