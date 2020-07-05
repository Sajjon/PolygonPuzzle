//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2020-07-03.
//

import Foundation
import XCTest

@testable import PolygonPuzzle

final class FallingPieceEdgesOfFilledSquareOfBlockLTests: PieceEdgeFilledSquareTest {
    
    // MARK: Top
    func test_assert_top_most_filled_square_of_block_l() {
        doTest(edge: .top, expected: [.first, .second, .first, .first])
    }
    
    // MARK: Bottom
    func test_assert_bottom_most_filled_square_of_block_l() {
        doTest(edge: .bottom, expected: [.third, .third, .third, .second])
    }
    
    // MARK: Left
    func test_assert_left_most_filled_square_of_block_l() {
        doTest(edge: .left, expected: [.second, .first, .first, .first])
    }
    
    // MARK: Right
    func test_assert_right_most_filled_square_of_block_l() {
        doTest(edge: .right, expected: [.third, .third, .second, .third])
    }
}

private extension FallingPieceEdgesOfFilledSquareOfBlockLTests {
    func doTest(edge: Edge, expected: [Int]) {
        doTest(rotationsOfBlock: .lBlock, edge: edge, expected: expected)
    }
}
