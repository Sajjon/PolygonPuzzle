//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2020-07-04.
//

import Foundation
import XCTest

@testable import PolygonPuzzle

extension Row {
    static func empty(width: Int = Self.minimumWidth) -> Self {
        .init(repeating: .empty, count: width)
    }
}

final class InlayPieceInRowsTests: TestCase {

    func test_that_reduction_of_simple_rows_does_not_throw_error() throws {
        XCTAssertNoThrow(
            try Rows.reduce(
                state: [
                    [0, 0, 0, 0, 0],
                    [0, 0, 0, 0, 0],
                    [0, 0, 0, 0, 0],
                    [0, 0, 0, 0, 0],
                    [0, 0, 0, 0, 0]
                ],
                inlaying: FallingPiece(block: .iBlock, rotationState: .identity)
            ).get()
        )
    }

    func test_assert_that_when_merging_a_piece_rotation_identity_that_is_not_in_frame_with_rows_we_get_result__pieceNotInFrame() throws {
        let rows: Rows = [
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0]
        ]
        
        let piece = FallingPiece(block: .iBlock, rotationState: .identity)
        
        let reduction = try XCTGet(Rows.reduce(state: rows, inlaying: piece))
        XCTAssertEqual(reduction, Rows.RowsReduction.pieceNotInFrame(rowsIncludingFallingPiece: [
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0]
        ]))
    }
    
    func test_assert_that_when_merging_a_piece_rotation_identity_at_row0_with_rows_with_overlapping_squares_an_error_is_thrown() {
        func assertCollision(rows: Rows) {
            let piece = FallingPiece(block: .iBlock, rotationState: .identity, coordinate: .zero)
            XCTFailure(
                Rows.reduce(state: rows, inlaying: piece),
                failsWithError: Rows.InlayPieceError.squaresOverlap
            )
        }
        
        assertCollision(
            rows: [
                [0, 0, 0, 0, 0],
                [1, 0, 0, 0, 0], // <--- `piece` will fill this row with rotationState `.identity`
                [0, 0, 0, 0, 0],
                [0, 0, 0, 0, 0],
                [0, 0, 0, 0, 0]
                
            ]
        )
        
        assertCollision(
            rows: [
                [0, 0, 0, 0, 0],
                [0, 1, 0, 0, 0], // <--- `piece` will fill this row with rotationState `.identity`
                [0, 0, 0, 0, 0],
                [0, 0, 0, 0, 0],
                [0, 0, 0, 0, 0]
            ]
        )
        
        assertCollision(
            rows: [
                [0, 0, 0, 0, 0],
                [0, 0, 1, 0, 0], // <--- `piece` will fill this row with rotationState `.identity`
                [0, 0, 0, 0, 0],
                [0, 0, 0, 0, 0],
                [0, 0, 0, 0, 0]
            ]
        )
        
        assertCollision(
            rows: [
                [0, 0, 0, 0, 0],
                [0, 0, 0, 1, 0], // <--- `piece` will fill this row with rotationState `.identity`
                [0, 0, 0, 0, 0],
                [0, 0, 0, 0, 0],
                [0, 0, 0, 0, 0]
            ]
        )
    }
    
    func test_assert_that_when_merging_a_piece_rotation_identity_at_row_minus1_with_rows_with_overlapping_squares_an_error_is_thrown() {
        func assertCollision(rows: Rows) {
            let piece = FallingPiece(block: .iBlock, rotationState: .identity, coordinate: .init(column: 0, row: -1))
            XCTFailure(
                Rows.reduce(state: rows, inlaying: piece),
                failsWithError: Rows.InlayPieceError.squaresOverlap
            )
        }
        
        assertCollision(
            rows: [
                [1, 0, 0, 0, 0], // <--- `piece` will fill this row with rotationState `.identity`
                [0, 0, 0, 0, 0],
                [0, 0, 0, 0, 0],
                [0, 0, 0, 0, 0],
                [0, 0, 0, 0, 0]
            ]
        )
        
        assertCollision(
            rows: [
                [0, 1, 0, 0, 0], // <--- `piece` will fill this row with rotationState `.identity`
                [0, 0, 0, 0, 0],
                [0, 0, 0, 0, 0],
                [0, 0, 0, 0, 0],
                [0, 0, 0, 0, 0]
            ]
        )
        
        
        assertCollision(
            rows: [
                [0, 0, 1, 0, 0], // <--- `piece` will fill this row with rotationState `.identity`
                [0, 0, 0, 0, 0],
                [0, 0, 0, 0, 0],
                [0, 0, 0, 0, 0],
                [0, 0, 0, 0, 0]
            ]
        )
        
        assertCollision(
            rows: [
                [0, 0, 0, 1, 0], // <--- `piece` will fill this row with rotationState `.identity`
                [0, 0, 0, 0, 0],
                [0, 0, 0, 0, 0],
                [0, 0, 0, 0, 0],
                [0, 0, 0, 0, 0]
            ]
        )
    }
    
    func test_assert_that_when_merging_a_piece_rotation_idπClockwise_at_row_minus1_with_rows_with_overlapping_squares_at_row_of_id_rotation_no_error_is_thrown() {
        
        func assertNoCollision(rows: Rows) {
            let piece = FallingPiece(block: .iBlock, rotationState: .idπClockwise, coordinate: .init(column: 0, row: -1))
            XCTAssertNoThrow(try Rows.reduce(state: rows, inlaying: piece).get())
        }
        
        assertNoCollision(
            rows: [
                [0, 0, 0, 0, 0],
                [0, 0, 0, 0, 0], // <--- `piece` will fill this row with rotationState `.identity`
                [0, 0, 0, 0, 0],
                [0, 0, 0, 0, 0],
                [1, 0, 0, 0, 0]
            ]
        )
        
        assertNoCollision(
            rows: [
                [0, 0, 0, 0, 0],
                [0, 0, 0, 0, 0], // <--- `piece` will fill this row with rotationState `.identity`
                [0, 0, 0, 0, 0],
                [1, 1, 0, 0, 0],
                [0, 0, 0, 0, 0]
            ]
        )
        
        assertNoCollision(
            rows: [
                [0, 0, 0, 0, 0],
                [0, 0, 0, 0, 0], // <--- `piece` will fill this row with rotationState `.identity`
                [0, 0, 0, 0, 0],
                [1, 1, 1, 0, 0],
                [0, 0, 0, 0, 0]
            ]
        )
        
        
        assertNoCollision(
            rows: [
                [0, 0, 0, 0, 0],
                [0, 0, 0, 0, 0], // <--- `piece` will fill this row with rotationState `.identity`
                [0, 0, 0, 0, 0],
                [1, 1, 0, 1, 0],
                [0, 0, 0, 0, 0]
            ]
        )
    }
    
    func test_assert_that_when_merging_a_piece_rotation_idπ½Clockwise_at_row0_with_rows_with_overlapping_squares_an_error_is_thrown() {
        func assertReduction(pieceColumn: Int, expectCollision: Bool, rows: Rows) {
            let piece = FallingPiece(block: .iBlock, rotationState: .idπ½Clockwise, coordinate: .init(column: pieceColumn, row: 0))
            if expectCollision {
                XCTFailure(
                    Rows.reduce(state: rows, inlaying: piece),
                    failsWithError: Rows.InlayPieceError.squaresOverlap
                )
            } else {
                XCTAssertNoThrow(try Rows.reduce(state: rows, inlaying: piece).get())
            }
        }
        
        assertReduction(
            pieceColumn: 0,
            expectCollision: true,
            rows: [
                [0, 0, 1, 0, 0],
                [0, 0, 0, 0, 0],
                [0, 0, 0, 0, 0],
                [0, 0, 0, 0, 0],
                [0, 0, 0, 0, 0]
                //            ^
                // piece here
            ]
        )
        
        assertReduction(
            pieceColumn: 0,
            expectCollision: true,
            rows: [
                [0, 0, 0, 0, 0],
                [0, 0, 1, 0, 0],
                [0, 0, 0, 0, 0],
                [0, 0, 0, 0, 0],
                [0, 0, 0, 0, 0]
                //            ^
                // piece here
            ]
        )
        
        assertReduction(
            pieceColumn: 0,
            expectCollision: true,
            rows: [
                [0, 0, 0, 0, 0],
                [0, 0, 0, 0, 0],
                [0, 0, 1, 0, 0],
                [0, 0, 0, 0, 0],
                [0, 0, 0, 0, 0]
                //            ^
                // piece here
            ]
        )
        assertReduction(
            pieceColumn: 0,
            expectCollision: true,
            rows: [
                [0, 0, 0, 0, 0],
                [0, 0, 0, 0, 0],
                [0, 0, 0, 0, 0],
                [0, 0, 1, 0, 0],
                [0, 0, 0, 0, 0]
                //            ^
                // piece here
            ]
        )
        
        assertReduction(
            pieceColumn: 0,
            expectCollision: false,
            rows: [
                [1, 1, 0, 0, 0],
                [1, 1, 0, 0, 0],
                [1, 1, 0, 0, 0],
                [1, 1, 0, 0, 0],
                [1, 1, 0, 0, 0]
                //            ^
                // piece here
            ]
        )
    }
    
    func test_collision_no_rows_cleared() throws {
        assertContact(
            piece: FallingPiece(block: .iBlock, rotationState: .identity, coordinate: .zero),
            before:
                """
                                🤍🤍🤍🤍🤍
                                🤍🤍🤍🤍🤍
                                🤍🤍💛🤍🤍
                                🤍🤍💛🤍🤍
                                🤍🤍💛🤍🤍
                                """
            ,
            contact: .noFilledRows(
                rowsAfterContact:
                    """
                                        🤍🤍🤍🤍🤍
                                        🤎🤎🤎🤎🤍
                                        🤍🤍💛🤍🤍
                                        🤍🤍💛🤍🤍
                                        🤍🤍💛🤍🤍
                                        """
            )
            
        )
    }
    
    func test_contact_clearing_rows_2_column2() {
        assertContact(
            piece: FallingPiece(block: .iBlock, rotationState: .idπ½Clockwise, coordinate: .init(column: 2, row: 1)),
            
            before:
                """
                                🤍🤍🤍🤍🤍
                                🤍🤍🤍🤍🤍
                                🤍🤍🤍🤍🤍
                                💛💛💛💛🤍
                                💛💛💛💛🤍
                                """
            ,
            
            contact: .didFillAndClearRows(
                
                collidedRowsBeforeBeingCleared:
                    """
                                        🤍🤍🤍🤍🤍
                                        🤍🤍🤍🤍🤎
                                        🤍🤍🤍🤍🤎
                                        💛💛💛💛🤎
                                        💛💛💛💛🤎
                                        """
                ,
                
                rowsAfterBeingCleared:
                    """
                                        🤍🤍🤍🤍🤍
                                        🤍🤍🤍🤍🤍
                                        🤍🤍🤍🤍🤍
                                        🤍🤍🤍🤍🤎
                                        🤍🤍🤍🤍🤎
                                        """
                ,
                
                numberOfRowsCleared: 2
            )
        )
    }
    
    func test_tiles_from_string() {
        let tiles: [Tile] = ["💛", "💙"]
        XCTAssertEqual(tiles, [.yellow, .blue])
    }
    
    func test_row_from_string() {
        let row: Row = "💛💙❤️💜🤍"
        XCTAssertEqual(row, [.yellow, .blue, .red, .purple, .empty])
    }
    
    func test_contact_clearing_rows_3_column1_non_continous() {
        assertContact(
            piece: FallingPiece(block: .iBlock, rotationState: .idπ½Clockwise, coordinate: .init(column: 1, row: 1)),
            before:
                """
                                🤍🤍🤍🤍🤍
                                💚💚💚🤍💙
                                💚💚💚🤍❤️
                                💚💚💚🤍🤍
                                💚💚💚🤍💜
                                """
            ,
            contact: .didFillAndClearRows(
                collidedRowsBeforeBeingCleared:
                    """
                                        🤍🤍🤍🤍🤍
                                        💚💚💚🤎💙
                                        💚💚💚🤎❤️
                                        💚💚💚🤎🤍
                                        💚💚💚🤎💜
                                        """
                ,
                rowsAfterBeingCleared:
                    """
                                        🤍🤍🤍🤍🤍
                                        🤍🤍🤍🤍🤍
                                        🤍🤍🤍🤍🤍
                                        🤍🤍🤍🤍🤍
                                        💚💚💚🤎🤍
                                        """
                ,
                numberOfRowsCleared: 3
            )
        )
    }
    
    func test_contact_clearing_rows_t_block() {
        assertContact(
            piece: FallingPiece(block: .tBlock, rotationState: .idπClockwise, coordinate: .init(column: 1, row: 2)),
            before:
                """
                                🤍🤍🤍🤍🤍
                                💚🤍🤍🤍💛
                                🧡🤍🤍🤍🤎
                                💙🤍🤍🤍💙
                                ❤️❤️🤍❤️❤️
                                """
            ,
            contact: .didFillAndClearRows(
                collidedRowsBeforeBeingCleared:
                    """
                                        🤍🤍🤍🤍🤍
                                        💚🤍🤍🤍💛
                                        🧡🤍🤍🤍🤎
                                        💙💜💜💜💙
                                        ❤️❤️💜❤️❤️
                                        """
                ,
                rowsAfterBeingCleared:
                    """
                                        🤍🤍🤍🤍🤍
                                        🤍🤍🤍🤍🤍
                                        🤍🤍🤍🤍🤍
                                        💚🤍🤍🤍💛
                                        🧡🤍🤍🤍🤎
                                        """
                ,
                numberOfRowsCleared: 2
            )
        )
    }
    
    func test_contact_clearing_1row_t_block() {
        assertContact(
            piece: FallingPiece(block: .tBlock, rotationState: .identity, coordinate: .init(column: 1, row: 2)),
            
            before: [
                "🤍🤍🤍🤍🤍",
                "💚🤍🤍🤍💛",
                "🧡🤍🤍🤍🤎",
                "💙🤍🤍🤍💙",
                "❤️❤️🤍❤️❤️"
            ],
            
            contact: .didFillAndClearRows(
                collidedRowsBeforeBeingCleared: [
                    "🤍🤍🤍🤍🤍",
                    "💚🤍🤍🤍💛",
                    "🧡🤍💜🤍🤎",
                    "💙💜💜💜💙",
                    "❤️❤️🤍❤️❤️"
                ],
                rowsAfterBeingCleared: [
                    "🤍🤍🤍🤍🤍",
                    "🤍🤍🤍🤍🤍",
                    "💚🤍🤍🤍💛",
                    "🧡🤍💜🤍🤎",
                    "❤️❤️🤍❤️❤️"
                ],
                numberOfRowsCleared: 1
            )
        )
    }
}

extension TestCase {
    func assertContact(
        piece: FallingPiece,
        before rows: Rows,
        contact expectedContact: Rows.RowsReduction.Contact
    ) {
        let reduction: Rows.RowsReduction
        do {
            reduction = try XCTGet(Rows.reduce(state: rows, inlaying: piece))
        } catch {
            XCTFail("Unexpected error: \(error)")
            return
        }
        guard case .contact(let actualContact) = reduction else {
            XCTFail("Expected .contact, but got: \(reduction)")
            return
        }
        
        XCTAssertEqual(expectedContact, actualContact)
    }
    
}
