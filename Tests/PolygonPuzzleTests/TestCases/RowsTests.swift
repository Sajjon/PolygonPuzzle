//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2020-07-03.
//

import Foundation
import XCTest
@testable import PolygonPuzzle

final class RowsTests: TestCase {
    
    func test_assert_board_all_rows_same_width() {
        let rowWidth = 10
        let rows = Rows(ofWidth: rowWidth)
        
        for row in rows {
            XCTAssertEqual(row.width, rowWidth)
        }
    }
    
    func test_clearing_one_row_in_rows_does_not_affect_other_rows() {
        let rows: Rows = [
            Rows.Row.red(at: 0),
            Rows.Row.teal(at: 1),
            Rows.Row.blue(at: 2)
        ]
        let rowCount = 3
        XCTAssertEqual(rows.count, rowCount)
        
        func rowsIgnoringRow(at indexOfRowToIgnore: Int) -> Rows {
            let fewerRows = Rows(rows: rows.filter {
                $0.index != indexOfRowToIgnore
            })
            XCTAssertEqual(fewerRows.count, rowCount - 1)
            return fewerRows
        }
        let rowToIgnore = 1
        let before = rowsIgnoringRow(at: rowToIgnore)
        assertOnlyTileIsMutatedWhenClearing(filledRow: rows[rowToIgnore], expectedRowIndex: rowToIgnore)
        let after = rowsIgnoringRow(at: rowToIgnore)
        XCTAssertEqual(before, after)
    }
    
}
