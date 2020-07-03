//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2020-07-03.
//

import Foundation

public extension Block {
    static func layoutOfBlockT(rotation: BlockRotation) -> Layout {
        switch rotation {
        case .identity:
            return [
                [0, 0, 0],
                [1, 1, 1],
                [0, 1, 0]
            ]
        case .idπ½Clockwise:
            return [
                [0, 1, 0],
                [1, 1, 0],
                [0, 1, 0]
            ]
        case .idπClockwise:
            return [
                [0, 1, 0],
                [1, 1, 1],
                [0, 0, 0]
            ]
        case .id3π½Clockwise:
            return [
                [0, 1, 0],
                [0, 1, 1],
                [0, 1, 0]
            ]
        }
    }
}
