//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2020-07-03.
//

import Foundation

extension Square: CustomStringConvertible {
    public var description: String {
        "\(tile)"
    }
}

extension Square: CustomDebugStringConvertible {
    public var debugDescription: String {
        "(column: \(columnIndex), row: \(rowIndex)) \(tile)"
    }
}
