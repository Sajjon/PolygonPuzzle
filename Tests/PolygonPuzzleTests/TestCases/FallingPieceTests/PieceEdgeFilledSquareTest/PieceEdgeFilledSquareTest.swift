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
    
    func doTest(rotationsOfBlock block: Block, edge: Edge, expected: [Int]) {
        
        let actual: [Int] = RotationState.allCases.map { rotationState in
            let piece = FallingPiece(
                block: block,
                rotationState: rotationState,
                coordinate: .init(column: 0, row: 0)
            )
            let square = piece.firstFilledSquareFromEdge(edge)
            let squareKeyPath: KeyPath<Square, Int> = square.columnOrRowKeyPath(edge: edge)
            let actual = square[keyPath: squareKeyPath]
            return actual
        }
        
        XCTAssertEqual(expected, actual)
    }

}
