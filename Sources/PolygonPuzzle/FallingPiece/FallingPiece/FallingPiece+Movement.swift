//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2020-07-03.
//

import Foundation

private extension FallingPiece {
    enum Movement {
        case left, right, down
    }
    
    mutating func move(_ movement: Movement, amount: Int = 1) {
        switch movement {
        case .left: abstractFrame.coordinate.x -= amount
        case .right: abstractFrame.coordinate.x += amount
        case .down: abstractFrame.coordinate.y += amount
        }
    }
}

public extension FallingPiece {
    
    enum Error: Swift.Error {
        case cannotMoveLeftIsAtEdge
    }
    
    mutating func moveDown() {
        move(.down)
    }
    
    mutating func moveLeft() throws {
        if leftMostFilledSquare.columnIndex == 0 {
            throw Error.cannotMoveLeftIsAtEdge
        }
        move(.left)
    }
    
    mutating func moveRight() {
        move(.right)
    }
}
