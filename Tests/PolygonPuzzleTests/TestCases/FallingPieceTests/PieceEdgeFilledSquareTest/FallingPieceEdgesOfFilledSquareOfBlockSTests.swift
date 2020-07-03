//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2020-07-03.
//

import Foundation
import XCTest

@testable import PolygonPuzzle

/// This test will have identical expected values as the Block Z tests
final class FallingPieceEdgesOfFilledSquareOfBlockSTests: PieceEdgeFilledSquareTest {
    
    // MARK: Top
    func test_assert_top_most_filled_square_of_block_s() {
        doTest(side: .top, expected: [.first, .first, .second, .first])
    }
    
    // MARK: Bottom
    func test_assert_bottom_most_filled_square_of_block_s() {
        doTest(side: .bottom, expected: [.second, .third, .third, .third])
    }
    
    // MARK: Left
    func test_assert_left_most_filled_square_of_block_s() {
        doTest(side: .left, expected: [.first, .second, .first, .first])
    }
    
    // MARK: Right
    func test_assert_right_most_filled_square_of_block_s() {
        doTest(side: .right, expected: [.third, .third, .third, .second])
    }
}

private extension FallingPieceEdgesOfFilledSquareOfBlockSTests {
    func doTest(side: Side, expected: [Int]) {
        doTest(rotationsOfBlock: .sBlock, side: side, expected: expected)
    }
}
