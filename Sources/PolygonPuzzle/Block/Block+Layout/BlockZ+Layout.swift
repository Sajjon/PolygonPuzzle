//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2020-07-03.
//

import Foundation

public extension Block {
    static func layoutOfBlockZ(rotationState: RotationState) -> Layout {
        switch rotationState {
        case .identity:
            return [
                [1, 1, 0],
                [0, 1, 1],
                [0, 0, 0]
            ]
        case .idπ½Clockwise:
            return [
                [0, 0, 1],
                [0, 1, 1],
                [0, 1, 0]
            ]
        case .idπClockwise:
            return [
                [0, 0, 0],
                [1, 1, 0],
                [0, 1, 1]
            ]
        case .id3π½Clockwise:
            return [
                [0, 1, 0],
                [1, 1, 0],
                [1, 0, 0]
            ]
        }
    }
}
