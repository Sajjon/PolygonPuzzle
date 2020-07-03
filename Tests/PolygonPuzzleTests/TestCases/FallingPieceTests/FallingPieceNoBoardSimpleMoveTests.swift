//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2020-07-03.
//

import XCTest
@testable import PolygonPuzzle

final class FallingPieceNoBoardSimpleMoveTests: XCTestCase {
    
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
    
    func test_assert_when_trying_to_move_a_piece_at_left_edge_left_an_error_is_thrown() {
        var piece = FallingPiece(block: .iBlock)
        XCTAssertEqual(piece.coordinateOfTopLeftCornerOfBoundingBox.x, 0)
        XCTAssertThrowsError(try piece.moveLeft())
    }
    
    func test_assert_column_of_piece_not_at_left_edge_moved_left_is_decreased_by_one() {
        var piece = FallingPiece.init(block: .iBlock, coordinate: .init(x: 1, y: 0))
        let columnBeforeMove = piece.coordinateOfTopLeftCornerOfBoundingBox.x
        XCTAssertGreaterThan(columnBeforeMove, 0)
        XCTAssertNoThrow(try piece.moveLeft())
        XCTAssertEqual(piece.coordinateOfTopLeftCornerOfBoundingBox.x, columnBeforeMove - 1)
    }
    
    func test_assert_row_of_piece_not_at_left_edge_moved_left_is_unaffected() {
        var piece = FallingPiece.init(block: .iBlock, coordinate: .init(x: 1, y: 0))
        let rowBeforeMove = piece.coordinateOfTopLeftCornerOfBoundingBox.y
        XCTAssertNoThrow(try piece.moveLeft())
        XCTAssertEqual(piece.coordinateOfTopLeftCornerOfBoundingBox.y, rowBeforeMove)
    }
}
