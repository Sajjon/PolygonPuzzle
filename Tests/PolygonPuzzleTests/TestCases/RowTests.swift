//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2020-07-03.
//

import XCTest
@testable import PolygonPuzzle

final class RowTests: TestCase {
    

    // MARK: Row
    func test_assert_row_filled_4_yellow() {
        assertRowIsFilled([.yellow, .yellow, .yellow, .yellow])
    }
    
    func test_assert_row_filled_2_red_3_teal() {
        assertRowIsFilled([.red, .red, .teal, .teal, .teal])
    }
    
    func test_assert_row_not_filled_one_of_four_empty() {
        assertRowIsNotFilled([.empty, .yellow, .yellow, .yellow])
    }
    
    func test_assert_clearing_rows_mutates_tile_and_only_tile() {
        assertOnlyTileIsMutatedWhenClearing(filledRow: [.red, .red, .red, .red])
    }
}
