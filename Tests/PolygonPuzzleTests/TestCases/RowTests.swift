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
    func test_assert_row_filled_5_squares() {
        assertRowIsFilled([1, 1, 1, 1, 1])
    }
    
    func test_assert_row_filled_5_squares_mixed() {
        assertRowIsFilled([1, 1, 2, 2, 2])
    }
    
    func test_assert_row_not_filled_one_of_five_empty() {
        assertRowIsNotFilled([0, 1, 1, 1, 1])
    }
    
    func test_assert_row_empty_5_squares() {
        assertRowIsEmpty([0, 0, 0, 0, 0])
    }
    
    func test_assert_row_empty_6_squares() {
        assertRowIsEmpty([0, 0, 0, 0, 0, 0])
    }
    
    func test_assert_row_not_empty_one_of_five_filled() {
        assertRowIsNotEmpty([0, 0, 0, 1, 0])
    }

}
