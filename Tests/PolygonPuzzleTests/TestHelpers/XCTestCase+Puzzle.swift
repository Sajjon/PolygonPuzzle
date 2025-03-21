//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2020-07-03.
//

import Foundation
import XCTest
@testable import PolygonPuzzle

extension TestCase {
    
    func assertRowIsFilled(
        _ row: Row,
        _ line: Int = #line, _ file: String = #file
    ) {
        assertRowIsFilledOrNot(row, expectedToBeFilled: true, line, file)
    }
    
    func assertRowIsNotFilled(
        _ row: Row,
        _ line: Int = #line, _ file: String = #file
    ) {
        assertRowIsFilledOrNot(row, expectedToBeFilled: false, line, file)
    }
    
    private func assertRowIsFilledOrNot(
        _ row: Row, expectedToBeFilled: Bool,
        _ line: Int = #line, _ file: String = #file
    ) {
        let isFilled = row.isFilled
        if expectedToBeFilled {
            XCTAssertTrue(isFilled)
        } else {
            XCTAssertFalse(isFilled)
        }
    }
    
    func assertRowIsEmpty(
        _ row: Row,
        _ line: Int = #line, _ file: String = #file
    ) {
        assertRowIsEmptyOrNot(row, expectedToBeEmpty: true, line, file)
    }
    
    func assertRowIsNotEmpty(
        _ row: Row,
        _ line: Int = #line, _ file: String = #file
    ) {
        assertRowIsEmptyOrNot(row, expectedToBeEmpty: false, line, file)
    }
    
    private func assertRowIsEmptyOrNot(
        _ row: Row, expectedToBeEmpty: Bool,
        _ line: Int = #line, _ file: String = #file
    ) {
        let isEmpty = row.isEmpty
        if expectedToBeEmpty {
            XCTAssertTrue(isEmpty)
        } else {
            XCTAssertFalse(isEmpty)
        }
    }
    
//    func assertOnlyTileIsMutatedWhenClearing(filledRow row: Row, expectedRowIndex: Int = 0) {
//        XCTAssertTrue(row.isFilled)
//        var row = row
//        let filledTile = row[0].tile
//        let rowWidth = row.width
//        
//        func assertCorrectColumnIndices(expectedTile: Tile) {
//            XCTAssertEqual(row.width, rowWidth)
//            func assertCorrectColumn(_ columnIndex: Int) {
//                let square = row[columnIndex]
//                XCTAssertEqual(square.rowIndex, expectedRowIndex)
//                XCTAssertEqual(square.columnIndex, columnIndex)
//                XCTAssertEqual(square.tile, expectedTile)
//            }
//            for columnIndex in 0..<rowWidth {
//                assertCorrectColumn(columnIndex)
//            }
//        }
//        
//        // AFTER
//        assertCorrectColumnIndices(expectedTile: filledTile)
//        
//        // CLEAR ROW
//        row.clear()
//        
//        // AFTER
//        assertCorrectColumnIndices(expectedTile: .empty)
//    }
}
