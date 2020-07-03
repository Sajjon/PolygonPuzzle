//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2020-07-03.
//

import Foundation
import Foundation
import XCTest

@testable import PolygonPuzzle

final class FallingPieceEdgesOfFilledSquareOfBlockOTests: PieceEdgeFilledSquareTest {
    
    // MARK: Top
    func test_assert_top_most_filled_square_of_block_o() {
        doTest(side: .top, expected: .first)
    }
    
    // MARK: Bottom
    func test_assert_bottom_most_filled_square_of_block_o() {
        doTest(side: .bottom, expected: .second)
    }
    
    // MARK: Left
    func test_assert_left_most_filled_square_of_block_o() {
        doTest(side: .left, expected: .first)
    }
    
    // MARK: Right
    func test_assert_right_most_filled_square_of_block_o() {
        doTest(side: .right, expected: .second)
    }
}

private extension FallingPieceEdgesOfFilledSquareOfBlockOTests {
    func doTest(side: Side, expected: Int) {
        doTest(rotationsOfBlock: .oBlock, side: side, expected: .init(repeating: expected, count: BlockRotation.allCases.count))
    }
}
