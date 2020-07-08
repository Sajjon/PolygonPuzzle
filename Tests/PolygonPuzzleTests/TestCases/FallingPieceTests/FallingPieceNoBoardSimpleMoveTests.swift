//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2020-07-03.
//

import XCTest
@testable import PolygonPuzzle

final class FallingPieceNoBoardSimpleMoveTests: TestCase {
    
    func test_assert_row_of_piece_moved_down_is_incremented_by_one() {
        var piece = FallingPiece(block: .iBlock)
        let rowBeforeMove = piece.bottomMostFilledSquare.rowIndex
        piece.moveDown()
        XCTAssertEqual(piece.bottomMostFilledSquare.rowIndex, rowBeforeMove + 1)
    }

    func test_assert_column_of_piece_moved_down_is_unaffected() {
        var piece = FallingPiece(block: .iBlock)
        let columnBeforeMove = piece.rightMostFilledSquare.columnIndex
        piece.moveDown()
        XCTAssertEqual(piece.rightMostFilledSquare.columnIndex, columnBeforeMove)
    }

    func test_assert_column_of_piece_at_left_edge_moved_right_is_incremented_by_one() {
        // Given a piece...
        var piece = FallingPiece(block: .iBlock)
        // that is at the left most edge
        let columnBeforeMove = piece.leftMostFilledSquare.columnIndex
        XCTAssertEqual(columnBeforeMove, 0, "should be at the left most edge")
        // When moved right
        piece.moveRight()
        // Then piece should have moved one column to the right
        XCTAssertEqual(piece.leftMostFilledSquare.columnIndex, columnBeforeMove + 1, "then piece should have moved one column to the right")
    }

    func test_assert_row_of_piece_moved_right_is_unaffected() {
        // Given a piece...
        var piece = FallingPiece(block: .iBlock)
        // that is at the left most edge
        let rowBeforeMove = piece.topMostFilledSquare.rowIndex
        // When moved right
        piece.moveRight()
        // Then piece should have moved one column to the right
        XCTAssertEqual(piece.topMostFilledSquare.rowIndex, rowBeforeMove)
    }

    func test_assert_when_trying_to_move_a_horizontal_block_i_piece_with_bounding_box_at_left_edge_to_the_left_an_error_is_thrown() {
        func assertFail(rotationState: RotationState) {
            var piece = FallingPiece(block: .iBlock, rotationState: rotationState)
            XCTAssertEqual(piece.leftMostFilledSquare.columnIndex, 0)
            XCTAssertThrowsError(try piece.moveLeft(), "Expected to not be able to move piece: \(piece) to the left. but was incorrectly able to.")
        }
        assertFail(rotationState: .identity)
        assertFail(rotationState: .idπClockwise)
    }

    func test_GIVEN_vertical_block_i_piece_with_bounding_box_at_left_edge_WHEN_try_move_it_to_the_left_THEN_the_column_index_is_decreased_by_one() {
        func doTest(rotationState: RotationState, startColumn: Int, shouldFail: Bool) {
            var piece = FallingPiece(block: .iBlock, rotationState: rotationState, coordinate: .init(column: startColumn, row: 0))
            if shouldFail {
                XCTAssertThrowsError(try piece.moveLeft())
            } else {
                let leftmostColumnBeforeMove = piece.leftMostFilledSquare.columnIndex
                XCTAssertNoThrow(try piece.moveLeft())
                let leftmostColumnAfterMove = piece.leftMostFilledSquare.columnIndex
                XCTAssertEqual(leftmostColumnAfterMove, leftmostColumnBeforeMove - 1)
                
            }
            
        }
        doTest(rotationState: .idπ½Clockwise, startColumn: 0, shouldFail: false)
        doTest(rotationState: .idπ½Clockwise, startColumn: -1, shouldFail: false)
        doTest(rotationState: .idπ½Clockwise, startColumn: -2, shouldFail: true)
        
        doTest(rotationState: .id3π½Clockwise, startColumn: 0, shouldFail: false)
        doTest(rotationState: .id3π½Clockwise, startColumn: -1, shouldFail: true)
        
    }
    
    func test_assert_column_of_piece_not_at_left_edge_moved_left_is_decreased_by_one() {
        func doTest(rotationState: RotationState) {
            var piece = FallingPiece(block: .iBlock, rotationState: rotationState, coordinate: .init(x: 1, y: 0))
            let columnBeforeMove = piece.leftMostFilledSquare.columnIndex
            XCTAssertGreaterThan(columnBeforeMove, 0)
            XCTAssertNoThrow(try piece.moveLeft())
            XCTAssertEqual(piece.leftMostFilledSquare.columnIndex, columnBeforeMove - 1)
        }
        RotationState.allCases.forEach(doTest(rotationState:))
    }
    
    func test_assert_row_of_piece_not_at_left_edge_moved_left_is_unaffected() {
        var piece = FallingPiece.init(block: .iBlock, coordinate: .init(x: 1, y: 0))
        let rowBeforeMove = piece.topMostFilledSquare.rowIndex
        XCTAssertNoThrow(try piece.moveLeft())
        XCTAssertEqual(piece.topMostFilledSquare.rowIndex, rowBeforeMove)
    }
}
