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
        doTest(edge: .top, expected: [.first, .first, .second, .first])
    }
    
    // MARK: Bottom
    func test_assert_bottom_most_filled_square_of_block_t() {
        doTest(edge: .bottom, expected: [.second, .third, .third, .third])
    }
    
    // MARK: Left
    func test_assert_left_most_filled_square_of_block_t() {
        doTest(edge: .left, expected: [.first, .second, .first, .first])
    }
    
    // MARK: Right
    func test_assert_right_most_filled_square_of_block_t() {
        doTest(edge: .right, expected: [.third, .third, .third, .second])
    }
}

private extension FallingPieceEdgesOfFilledSquareOfBlockTTests {
    func doTest(edge: Edge, expected: [Int]) {
        doTest(rotationsOfBlock: .tBlock, edge: edge, expected: expected)
    }
}
