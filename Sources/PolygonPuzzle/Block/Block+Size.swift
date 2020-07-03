//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2020-07-03.
//

import Foundation
public extension Block {

    
    var size: Size {
        let layout = rawLayout(rotation: .identity)
        let height = layout.count
        assert(height > 0)
        let width = layout[0].count
        layout.forEach {
            assert($0.count == width)
        }
        return .init(width: width, height: height)
    }
}
