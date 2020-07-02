import XCTest
@testable import PolygonPuzzle

extension Board.Row: ExpressibleByArrayLiteral {
    public typealias ArrayLiteralElement = Board.Tile
    
    public init(arrayLiteral tiles: ArrayLiteralElement...) {
        let rowIndex = -1
        let width = tiles.count
       
        let squares = tiles.enumerated().map {
            Board.Square(
                columnIndex: $0.offset,
                rowIndex: rowIndex,
                tile: $0.element
            )
        }
        
        self.init(index: rowIndex, width: width, squares: squares)
    }
}

final class PolygonPuzzleTests: XCTestCase {
    func test_assert_row_filled_4_yellow() {
        assertRowIsFilled([.yellow, .yellow, .yellow, .yellow])
    }
    
    func test_assert_row_filled_2_red_3_teal() {
        assertRowIsFilled([.red, .red, .teal, .teal, .teal])
    }
    
    func test_assert_row_not_filled_one_of_four_empty() {
        assertRowIsNotFilled([.empty, .yellow, .yellow, .yellow])
    }
    
}

extension XCTestCase {
    
    func assertRowIsFilled(
        _ row: Board.Row,
        _ line: Int = #line, _ file: String = #file
    ) {
        assertRowIsFilledOrNot(row, expectedToBeFilled: true, line, file)
    }
    
    func assertRowIsNotFilled(
        _ row: Board.Row,
        _ line: Int = #line, _ file: String = #file
    ) {
        assertRowIsFilledOrNot(row, expectedToBeFilled: false, line, file)
    }
    
    private func assertRowIsFilledOrNot(
        _ row: Board.Row, expectedToBeFilled: Bool,
        _ line: Int = #line, _ file: String = #file
    ) {
        let isFilled = row.isFilled
        if expectedToBeFilled {
            XCTAssertTrue(isFilled)
        } else {
            XCTAssertFalse(isFilled)
        }
    }
}
