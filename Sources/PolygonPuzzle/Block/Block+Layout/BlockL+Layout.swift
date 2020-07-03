//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2020-07-03.
//

import Foundation

public extension Block {
    static func layoutOfBlockL(rotation: BlockRotation) -> Layout {
        switch rotation {
        case .identity:
            return [
                [0, 1, 0],
                [0, 1, 0],
                [0, 1, 1]
            ]
        case .idπ½Clockwise:
            return [
                [0, 0, 0],
                [1, 1, 1],
                [1, 0, 0]
            ]
        case .idπClockwise:
            return [
                [1, 1, 0],
                [0, 1, 0],
                [0, 1, 0]
            ]
        case .id3π½Clockwise:
            return [
                [0, 0, 1],
                [1, 1, 1],
                [0, 0, 0]
            ]
        }
    }
}
