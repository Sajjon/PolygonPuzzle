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
        let rowBeforeMove = piece.coordinateOfBottomRightCornerOfBoundingBox.y
        piece.moveDown()
        XCTAssertEqual(piece.coordinateOfBottomRightCornerOfBoundingBox.y, rowBeforeMove + 1)
    }
    
    func test_assert_column_of_piece_moved_down_is_unaffected() {
        var piece = FallingPiece(block: .iBlock)
        let columnBeforeMove = piece.coordinateOfBottomRightCornerOfBoundingBox.x
        piece.moveDown()
        XCTAssertEqual(piece.coordinateOfBottomRightCornerOfBoundingBox.x, columnBeforeMove)
    }
    
    func test_assert_column_of_piece_at_left_edge_moved_right_is_incremented_by_one() {
        // Given a piece...
        var piece = FallingPiece(block: .iBlock)
        // that is at the left most edge
        let columnBeforeMove = piece.coordinateOfTopLeftCornerOfBoundingBox.x
        XCTAssertEqual(columnBeforeMove, 0, "should be at the left most edge")
        // When moved right
        piece.moveRight()
        // Then piece should have moved one column to the right
        XCTAssertEqual(piece.coordinateOfTopLeftCornerOfBoundingBox.x, columnBeforeMove + 1, "then piece should have moved one column to the right")
    }
    
    func test_assert_row_of_piece_moved_right_is_unaffected() {
        // Given a piece...
        var piece = FallingPiece(block: .iBlock)
        // that is at the left most edge
        let rowBeforeMove = piece.coordinateOfTopLeftCornerOfBoundingBox.y
        // When moved right
        piece.moveRight()
        // Then piece should have moved one column to the right
        XCTAssertEqual(piece.coordinateOfTopLeftCornerOfBoundingBox.y, rowBeforeMove)
    }
    
    func test_assert_when_trying_to_move_a_horizontal_block_i_piece_with_bounding_box_at_left_edge_to_the_left_an_error_is_thrown() {
        func assertFail(rotation: BlockRotation) {
            var piece = FallingPiece(block: .iBlock, rotation: rotation)
            XCTAssertEqual(piece.coordinateOfTopLeftCornerOfBoundingBox.x, 0)
            XCTAssertThrowsError(try piece.moveLeft(), "Expected to not be able to move piece: \(piece) to the left. but was incorrectly able to.")
        }
        assertFail(rotation: .identity)
        assertFail(rotation: .idπClockwise)
    }
    
    func test_GIVEN_vertical_block_i_piece_with_bounding_box_at_left_edge_WHEN_try_move_it_to_the_left_THEN_the_column_index_is_decreased_by_one() {
        func assertFail(rotation: BlockRotation) {
            var piece = FallingPiece(block: .iBlock, rotation: rotation)
            let leftmostColumnBeforeMove = piece.coordinateOfTopLeftCornerOfBoundingBox.x
            XCTAssertEqual(leftmostColumnBeforeMove, 0)
            XCTAssertNoThrow(try piece.moveLeft())
            let leftmostColumnAfterMove = piece.coordinateOfTopLeftCornerOfBoundingBox.x
            XCTAssertEqual(leftmostColumnAfterMove, leftmostColumnBeforeMove - 1)
            XCTAssertEqual(leftmostColumnAfterMove, -1)
            
        }
        assertFail(rotation: .idπ½Clockwise)
        assertFail(rotation: .id3π½Clockwise)
    }
    
    func test_assert_column_of_piece_not_at_left_edge_moved_left_is_decreased_by_one() {
        func doTest(rotation: BlockRotation) {
            var piece = FallingPiece(block: .iBlock, rotation: rotation, coordinate: .init(x: 1, y: 0))
            let columnBeforeMove = piece.coordinateOfTopLeftCornerOfBoundingBox.x
            XCTAssertGreaterThan(columnBeforeMove, 0)
            XCTAssertNoThrow(try piece.moveLeft())
            XCTAssertEqual(piece.coordinateOfTopLeftCornerOfBoundingBox.x, columnBeforeMove - 1)
        }
        BlockRotation.allCases.forEach(doTest(rotation:))
    }
    
    func test_assert_row_of_piece_not_at_left_edge_moved_left_is_unaffected() {
        var piece = FallingPiece.init(block: .iBlock, coordinate: .init(x: 1, y: 0))
        let rowBeforeMove = piece.coordinateOfTopLeftCornerOfBoundingBox.y
        XCTAssertNoThrow(try piece.moveLeft())
        XCTAssertEqual(piece.coordinateOfTopLeftCornerOfBoundingBox.y, rowBeforeMove)
    }
}
