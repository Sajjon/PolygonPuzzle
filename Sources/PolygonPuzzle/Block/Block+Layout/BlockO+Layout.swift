//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2020-07-03.
//

import Foundation

public extension Block {
    static func layoutOfBlockO(rotationState: RotationState) -> Layout {
        // dont care about rotationState... same for every rotationState
        return [
            [1, 1],
            [1, 1]
        ]
    }
}
