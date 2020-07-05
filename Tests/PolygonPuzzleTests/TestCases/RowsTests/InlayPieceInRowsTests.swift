//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2020-07-04.
//

import Foundation
import XCTest

@testable import PolygonPuzzle

final class InlayPieceInRowsTests: TestCase {

    func test_that_reduction_of_simple_rows_does_not_throw_error() throws {
        XCTAssertNoThrow(
            try Rows.reduce(
                state: [
                    [0, 0, 0, 0],
                    [0, 0, 0, 0],
                    [0, 0, 0, 0],
                    [0, 0, 0, 0]
                ],
                inlaying: FallingPiece(block: .iBlock, rotation: .identity)
            ).get()
        )
    }

    func test_assert_that_when_merging_a_piece_rotation_identity_that_is_not_in_frame_with_rows_we_get_result__pieceNotInFrame() throws {
        let rows: Rows = [
            [0, 0, 0, 0],
            [0, 0, 0, 0],
            [0, 0, 0, 0],
            [0, 0, 0, 0]
        ]
        
        let piece = FallingPiece(block: .iBlock, rotation: .identity)
        
        let reduction = try XCTGet(Rows.reduce(state: rows, inlaying: piece))
        XCTAssertEqual(reduction, .pieceNotInFrame)
    }
    
    func test_assert_that_when_merging_a_piece_rotation_identity_at_row0_with_rows_with_overlapping_squares_an_error_is_thrown() {
        func assertCollision(rows: Rows) {
            let piece = FallingPiece(block: .iBlock, rotation: .identity, coordinate: .zero)
            XCTFailure(
                Rows.reduce(state: rows, inlaying: piece),
                failsWithError: Rows.InlayPieceError.squaresOverlap
            )
        }
        
        assertCollision(
            rows: [
                [0, 0, 0, 0],
                [1, 0, 0, 0], // <--- `piece` will fill this row with rotation `.identity`
                [0, 0, 0, 0],
                [0, 0, 0, 0]
            ]
        )
        
        assertCollision(
            rows: [
                [0, 0, 0, 0],
                [0, 1, 0, 0], // <--- `piece` will fill this row with rotation `.identity`
                [0, 0, 0, 0],
                [0, 0, 0, 0]
            ]
        )
        
        assertCollision(
            rows: [
                [0, 0, 0, 0],
                [0, 0, 1, 0], // <--- `piece` will fill this row with rotation `.identity`
                [0, 0, 0, 0],
                [0, 0, 0, 0]
            ]
        )
        
        assertCollision(
            rows: [
                [0, 0, 0, 0],
                [0, 0, 0, 1], // <--- `piece` will fill this row with rotation `.identity`
                [0, 0, 0, 0],
                [0, 0, 0, 0]
            ]
        )
    }
    
    func test_assert_that_when_merging_a_piece_rotation_identity_at_row_minus1_with_rows_with_overlapping_squares_an_error_is_thrown() {
        func assertCollision(rows: Rows) {
            let piece = FallingPiece(block: .iBlock, rotation: .identity, coordinate: .init(column: 0, row: -1))
            XCTFailure(
                Rows.reduce(state: rows, inlaying: piece),
                failsWithError: Rows.InlayPieceError.squaresOverlap
            )
        }
        
        assertCollision(
            rows: [
                [1, 0, 0, 0], // <--- `piece` will fill this row with rotation `.identity`
                [0, 0, 0, 0],
                [0, 0, 0, 0],
                [0, 0, 0, 0]
            ]
        )
        
        assertCollision(
            rows: [
                [0, 1, 0, 0], // <--- `piece` will fill this row with rotation `.identity`
                [0, 0, 0, 0],
                [0, 0, 0, 0],
                [0, 0, 0, 0]
            ]
        )
        
        
        assertCollision(
            rows: [
                [0, 0, 1, 0], // <--- `piece` will fill this row with rotation `.identity`
                [0, 0, 0, 0],
                [0, 0, 0, 0],
                [0, 0, 0, 0]
            ]
        )
        
        assertCollision(
            rows: [
                [0, 0, 0, 1], // <--- `piece` will fill this row with rotation `.identity`
                [0, 0, 0, 0],
                [0, 0, 0, 0],
                [0, 0, 0, 0]
            ]
        )
    }
    
    func test_assert_that_when_merging_a_piece_rotation_idπClockwise_at_row_minus1_with_rows_with_overlapping_squares_at_row_of_id_rotation_no_error_is_thrown() {
        
        func assertNoCollision(rows: Rows) {
            let piece = FallingPiece(block: .iBlock, rotation: .idπClockwise, coordinate: .init(column: 0, row: -1))
            XCTAssertNoThrow(try Rows.reduce(state: rows, inlaying: piece).get())
        }
        
        assertNoCollision(
            rows: [
                [0, 0, 0, 0],
                [0, 0, 0, 0], // <--- `piece` will fill this row with rotation `.identity`
                [1, 0, 0, 0],
                [0, 0, 0, 0]
            ]
        )
        
        assertNoCollision(
            rows: [
                [0, 0, 0, 0],
                [0, 0, 0, 0], // <--- `piece` will fill this row with rotation `.identity`
                [1, 1, 0, 0],
                [0, 0, 0, 0]
            ]
        )
        
        assertNoCollision(
            rows: [
                [0, 0, 0, 0],
                [0, 0, 0, 0], // <--- `piece` will fill this row with rotation `.identity`
                [1, 1, 1, 0],
                [0, 0, 0, 0]
            ]
        )
        
        
        assertNoCollision(
            rows: [
                [0, 0, 0, 0],
                [0, 0, 0, 0], // <--- `piece` will fill this row with rotation `.identity`
                [1, 1, 0, 1],
                [0, 0, 0, 0]
            ]
        )
    }
}
