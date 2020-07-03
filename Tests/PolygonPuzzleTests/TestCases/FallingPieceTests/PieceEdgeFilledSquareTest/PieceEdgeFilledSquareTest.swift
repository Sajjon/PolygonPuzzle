//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2020-07-03.
//

import Foundation
import XCTest

@testable import PolygonPuzzle

extension Int {
    static let first = 0
    static let second = 1
    static let third = 2
    static let fourth = 3
}

class PieceEdgeFilledSquareTest: TestCase {
    
    func doTest(rotationsOfBlock block: Block, side: Side, expected: [Int]) {
        
        let actual: [Int] = BlockRotation.allCases.map { rotation in
            let piece = FallingPiece(
                block: block,
                rotation: rotation,
                coordinate: .init(column: 0, row: 0)
            )
            let square = piece.firstFilledSquareFromSide(side)
            let squareKeyPath: KeyPath<Square, Int> = square.columnOrRowKeyPath(side: side)
            let actual = square[keyPath: squareKeyPath]
            return actual
        }
        
        XCTAssertEqual(expected, actual)
    }

}

enum Side {
    case top, bottom, left, right
}

extension FallingPiece {
    
    func firstFilledSquareFromSide(_ side: Side) -> Square {
        switch side {
        case .top: return topMostFilledSquare
        case .bottom: return bottomMostFilledSquare
        case .left: return leftMostFilledSquare
        case .right: return rightMostFilledSquare
        }
    }
    
}

extension Square {
    func columnOrRowKeyPath(side: Side) -> KeyPath<Self, Int> {
        switch side {
        case .left, .right: return \.columnIndex
        case .top, .bottom: return \.rowIndex
        }
    }
}
