import XCTest
@testable import PolygonPuzzle

extension Rows.Row: ExpressibleByArrayLiteral {
    public typealias ArrayLiteralElement = Tile
    
    public init(arrayLiteral tiles: ArrayLiteralElement...) {
        self.init(tiles: tiles)
    }
    
    init(tiles: [Tile], index rowIndex: Int = 0) {
        let width = tiles.count
       
        let squares = tiles.enumerated().map {
            Square(
                columnIndex: $0.offset,
                rowIndex: rowIndex,
                tile: $0.element
            )
        }
        
        self.init(at: rowIndex, width: width, squares: squares)
    }
    
    init(repeating tile: Tile, count: Int, index: Int = 0) {
        self.init(tiles: .init(repeating: tile, count: count), index: index)
    }
    
    static func red(at index: Int = 0, width: Int = Self.minimumWidth) -> Self {
        .init(repeating: .red, count: width, index: index)
    }
    
    static func teal(at index: Int = 0, width: Int = Self.minimumWidth) -> Self {
        .init(repeating: .teal, count: width, index: index)
    }
    
    static func blue(at index: Int = 0, width: Int = Self.minimumWidth) -> Self {
        .init(repeating: .blue, count: width, index: index)
    }
}

final class PolygonPuzzleTests: XCTestCase {
    
    // MARK: Rows
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
    
    // MARK: FallingPiece
    func test_assert_falling_piece_init_without_rotation_starts_at_identity() {
        let piece = FallingPiece(block: .iBlock)
        XCTAssertEqual(piece.rotation, .identity)
    }
    
    func test_assert_falling_piece_size_equals_size_of_block() {
        func doTestSizeOfPieceEqualsSize(ofBlock block: Block) {
            let piece = FallingPiece(block: block)
            XCTAssertEqual(piece.width, block.size.width)
            XCTAssertEqual(piece.height, block.size.height)
        }
        Block.allCases.forEach(doTestSizeOfPieceEqualsSize(ofBlock:))
    }
    
    func test_assert_falling_piece_corner_position_of_allblocks() {
        func doTest(block: Block) {
            let piece = FallingPiece(block: block)
            
            XCTAssertEqual(piece.coordinateOfBottomRightCornerOfBoundingBox,  Coordinate(
                x: piece.size.width - 1,
                y: -1
            ))
            
            XCTAssertEqual(
                piece.coordinateOfTopLeftCornerOfBoundingBox,
                Coordinate(
                    x: 0,
                    y: -block.size.height
                )
            )
        }
        
        Block.allCases.forEach(doTest(block:))
    }
    
    func test_corners_of_block_i_disregarding_rotation() {
        func doTestRotationAndCorners(_ rotation: BlockRotation) {
            let piece = FallingPiece(block: .iBlock, rotation: rotation)
            
            XCTAssertEqual(
                piece.coordinateOfBottomRightCornerOfBoundingBox,
                Coordinate(x: 3, y: -1)
            )
            
            XCTAssertEqual(
                piece.coordinateOfTopLeftCornerOfBoundingBox,
                Coordinate(x: 0, y: -4)
            )
        }
        BlockRotation.allCases.forEach(doTestRotationAndCorners)
    }
    
    func test_corners_of_block_o_disregarding_rotation() {
        func doTestRotationAndCorners(_ rotation: BlockRotation) {
            let piece = FallingPiece(block: .oBlock, rotation: rotation)
            
            XCTAssertEqual(
                piece.coordinateOfBottomRightCornerOfBoundingBox,
                Coordinate(x: 1, y: -1)
            )
            
            XCTAssertEqual(
                piece.coordinateOfTopLeftCornerOfBoundingBox,
                Coordinate(x: 0, y: -2)
            )
        }
        BlockRotation.allCases.forEach(doTestRotationAndCorners)
    }
    
    
    func test_corners_of_block_z_disregarding_rotation() {
        func doTestRotationAndCorners(_ rotation: BlockRotation) {
            let piece = FallingPiece(block: .zBlock, rotation: rotation)
            
            XCTAssertEqual(
                piece.coordinateOfBottomRightCornerOfBoundingBox,
                Coordinate(x: 2, y: -1)
            )
            
            XCTAssertEqual(
                piece.coordinateOfTopLeftCornerOfBoundingBox,
                Coordinate(x: 0, y: -3)
            )
        }
        BlockRotation.allCases.forEach(doTestRotationAndCorners)
    }
    
    // MARK: Move Piece
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
    
    // MARK: Rotation
    func test_assert_when_rotating_rotation__identity__clockwise_by_π½_we_get_rotation__idπ½Clockwise() {
        XCTAssertEqual(BlockRotation.identity.clockwiseRotation(), .idπ½Clockwise)
    }
    
    func test_assert_when_rotating_rotation__idπ½Clockwise__clockwise_by_π½_we_get_rotation__idπClockwise() {
        XCTAssertEqual(BlockRotation.idπ½Clockwise.clockwiseRotation(), .idπClockwise)
    }

    func test_assert_when_rotating_rotation__idπClockwise__clockwise_by_π½_we_get_rotation__id3π½Clockwise() {
        XCTAssertEqual(BlockRotation.idπClockwise.clockwiseRotation(), .id3π½Clockwise)
    }

    func test_assert_when_rotating_rotation__id3π½Clockwise__clockwise_by_π½_we_get_rotation__identity() {
        XCTAssertEqual(BlockRotation.id3π½Clockwise.clockwiseRotation(), .identity)
    }
    
    func test_assert_when_rotating_rotation__identity__counterClockwise_by_π½_we_get_rotation__id3π½Clockwise() {
        XCTAssertEqual(BlockRotation.identity.counterClockwiseRotation(), .id3π½Clockwise)
    }
    
    func test_assert_when_rotating_rotation__idπ½Clockwise__counterClockwise_by_π½_we_get_rotation__identity() {
        XCTAssertEqual(BlockRotation.idπ½Clockwise.counterClockwiseRotation(), .identity)
    }

    func test_assert_when_rotating_rotation__idπClockwise__counterClockwise_by_π½_we_get_rotation__idπ½Clockwise() {
        XCTAssertEqual(BlockRotation.idπClockwise.counterClockwiseRotation(), .idπ½Clockwise)
    }

    func test_assert_when_rotating_rotation__id3π½Clockwise__counterClockwise_by_π½_we_get_rotation__idπClockwise() {
        XCTAssertEqual(BlockRotation.id3π½Clockwise.counterClockwiseRotation(), .idπClockwise)
    }
}

extension XCTestCase {
    
    func assertRowIsFilled(
        _ row: Rows.Row,
        _ line: Int = #line, _ file: String = #file
    ) {
        assertRowIsFilledOrNot(row, expectedToBeFilled: true, line, file)
    }
    
    func assertRowIsNotFilled(
        _ row: Rows.Row,
        _ line: Int = #line, _ file: String = #file
    ) {
        assertRowIsFilledOrNot(row, expectedToBeFilled: false, line, file)
    }
    
    private func assertRowIsFilledOrNot(
        _ row: Rows.Row, expectedToBeFilled: Bool,
        _ line: Int = #line, _ file: String = #file
    ) {
        let isFilled = row.isFilled
        if expectedToBeFilled {
            XCTAssertTrue(isFilled)
        } else {
            XCTAssertFalse(isFilled)
        }
    }
    
    func assertOnlyTileIsMutatedWhenClearing(filledRow row: Rows.Row, expectedRowIndex: Int = 0) {
        XCTAssertTrue(row.isFilled)
        var row = row
        let filledTile = row[0].tile
        let rowWidth = row.width
        
        func assertCorrectColumnIndices(expectedTile: Tile) {
            XCTAssertEqual(row.width, rowWidth)
            func assertCorrectColumn(_ columnIndex: Int) {
                let square = row[columnIndex]
                XCTAssertEqual(square.rowIndex, expectedRowIndex)
                XCTAssertEqual(square.columnIndex, columnIndex)
                XCTAssertEqual(square.tile, expectedTile)
            }
            for columnIndex in 0..<rowWidth {
                assertCorrectColumn(columnIndex)
            }
        }
        
        // AFTER
        assertCorrectColumnIndices(expectedTile: filledTile)
        
        // CLEAR ROW
        row.clear()
        
        // AFTER
        assertCorrectColumnIndices(expectedTile: .empty)
    }
}
