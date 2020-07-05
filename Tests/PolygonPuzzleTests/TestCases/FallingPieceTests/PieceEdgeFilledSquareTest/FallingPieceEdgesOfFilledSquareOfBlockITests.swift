//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2020-07-03.
//

import Foundation
import XCTest

@testable import PolygonPuzzle

final class FallingPieceEdgesOfFilledSquareOfBlockITests: PieceEdgeFilledSquareTest {
    
    // MARK: Top
    func test_assert_top_most_filled_square_of_block_i() {
        doTest(edge: .top, expected: [.second, .first, .third, .first])
    }
    
    // MARK: Bottom
    func test_assert_bottom_most_filled_square_of_block_i() {
        doTest(edge: .bottom, expected: [.second, .fourth, .third, .fourth])
    }
    
    // MARK: Left
    func test_assert_left_most_filled_square_of_block_i() {
        doTest(edge: .left, expected: [.first, .third, .first, .second])
    }
    
    // MARK: Right
    func test_assert_right_most_filled_square_of_block_i() {
        doTest(edge: .right, expected: [.fourth, .third, .fourth, .second])
    }
}

private extension FallingPieceEdgesOfFilledSquareOfBlockITests {
    func doTest(edge: Edge, expected: [Int]) {
        doTest(rotationsOfBlock: .iBlock, edge: edge, expected: expected)
    }
}
