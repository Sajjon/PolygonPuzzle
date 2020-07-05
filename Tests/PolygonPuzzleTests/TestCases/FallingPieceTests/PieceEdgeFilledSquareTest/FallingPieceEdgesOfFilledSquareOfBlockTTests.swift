//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2020-07-03.
//

import Foundation
import XCTest

@testable import PolygonPuzzle

final class FallingPieceEdgesOfFilledSquareOfBlockTTests: PieceEdgeFilledSquareTest {
    
    // MARK: Top
    func test_assert_top_most_filled_square_of_block_t() {
        doTest(edge: .top, expected: [.second, .first, .first, .first])
    }
    
    // MARK: Bottom
    func test_assert_bottom_most_filled_square_of_block_t() {
        doTest(edge: .bottom, expected: [.third, .third, .second, .third])
    }
    
    // MARK: Left
    func test_assert_left_most_filled_square_of_block_t() {
        doTest(edge: .left, expected: [.first, .first, .first, .second])
    }
    
    // MARK: Right
    func test_assert_right_most_filled_square_of_block_t() {
        doTest(edge: .right, expected: [.third, .second, .third, .third])
    }
}

private extension FallingPieceEdgesOfFilledSquareOfBlockTTests {
    func doTest(edge: Edge, expected: [Int]) {
        doTest(rotationsOfBlock: .tBlock, edge: edge, expected: expected)
    }
}
