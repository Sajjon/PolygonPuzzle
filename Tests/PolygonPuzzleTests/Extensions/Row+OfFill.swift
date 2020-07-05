//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2020-07-03.
//

import Foundation
@testable import PolygonPuzzle

extension Row {
    
    static func red(at index: Int = 0, width: Int = Self.minimumWidth) -> Self {
        .init(repeating: .red, count: width, index: index)
    }
    
    static func teal(at index: Int = 0, width: Int = Self.minimumWidth) -> Self {
        .init(repeating: .teal, count: width, index: index)
    }
    
    static func blue(at index: Int = 0, width: Int = Self.minimumWidth) -> Self {
        .init(repeating: .blue, count: width, index: index)
    }
}
