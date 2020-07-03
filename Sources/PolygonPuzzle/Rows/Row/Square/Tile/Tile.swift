//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2020-07-03.
//

import Foundation

// MARK: Tile
public enum Tile: Hashable {
    
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
    
    static let yellow:  Self = .filled(.yellow)
    static let teal:    Self = .filled(.teal)
    static let red:     Self = .filled(.red)
    static let green:   Self = .filled(.green)
    static let orange:  Self = .filled(.orange)
    static let blue:    Self = .filled(.blue)
    static let purple:  Self = .filled(.purple)
}
