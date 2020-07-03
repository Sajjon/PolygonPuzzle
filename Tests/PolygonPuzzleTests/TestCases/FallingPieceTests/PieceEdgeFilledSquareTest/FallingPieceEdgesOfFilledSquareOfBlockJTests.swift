//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2020-07-03.
//

import Foundation
import XCTest

@testable import PolygonPuzzle

final class FallingPieceEdgesOfFilledSquareOfBlockJTests: PieceEdgeFilledSquareTest {
    
    // MARK: Top
    func test_assert_top_most_filled_square_of_block_j() {
        doTest(side: .top, expected: [.first, .first, .first, .second])
    }
    
    // MARK: Bottom
    func test_assert_bottom_most_filled_square_of_block_j() {
        doTest(side: .bottom, expected: [.third, .second, .third, .third])
    }
    
    // MARK: Left
    func test_assert_left_most_filled_square_of_block_j() {
        doTest(side: .left, expected: [.first, .first, .second, .first])
    }
    
    // MARK: Right
    func test_assert_right_most_filled_square_of_block_j() {
        doTest(side: .right, expected: [.second, .third, .third, .third])
    }
}

private extension FallingPieceEdgesOfFilledSquareOfBlockJTests {
    func doTest(side: Side, expected: [Int]) {
        doTest(rotationsOfBlock: .jBlock, side: side, expected: expected)
    }
}
