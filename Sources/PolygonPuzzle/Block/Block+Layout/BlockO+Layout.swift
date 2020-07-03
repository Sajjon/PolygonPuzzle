//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2020-07-03.
//

import Foundation

public extension Block {
    static func layoutOfBlockO(rotation: BlockRotation) -> Layout {
        // dont care about rotation... same for every rotation
        return [
            [1, 1],
            [1, 1]
        ]
    }
}
