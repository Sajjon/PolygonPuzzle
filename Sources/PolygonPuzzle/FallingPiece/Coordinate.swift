//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2020-07-03.
//

import Foundation

public struct Coordinate: Hashable {
    public typealias Value = Int
    public internal(set) var x: Value
    public internal(set) var y: Value
}

public extension Coordinate {
    init(column: Value, row: Value) {
        self.init(x: column, y: row)
    }
}
