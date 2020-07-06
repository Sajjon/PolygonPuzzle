//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2020-07-06.
//

import Foundation
import XCTest
@testable import PolygonPuzzle

final class FallingPieceRotationTests: TestCase {
    
    func test_create_board() {
        
        var board = Board(
            fallingBlock: .tBlock,
            fallingBlockRotation: .identity,
            nextBlock: .jBlock,
            numberOfRows: 5,
            ofWidth: 5
        )
        
        XCTAssertEqual(board.fallingPiece.block, .tBlock)
        XCTAssertEqual(board.fallingPiece.rotation, .identity)

        XCTAssertEqual(
            board.fallingPiece.bottomMostFilledSquare.rowIndex,
            -1
        )

        XCTAssertEqual(board.nextBlock, .jBlock)
        
        XCTAssertEqual(
            board.rowsIncludingFallingPiece,
            """
                        🤍  🤍  🤍  🤍  🤍
                        🤍  🤍  🤍  🤍  🤍
                        🤍  🤍  🤍  🤍  🤍
                        🤍  🤍  🤍  🤍  🤍
                        🤍  🤍  🤍  🤍  🤍
                        """
        )
        
        board.movePieceDown()
        XCTAssertEqual(
            board.rowsIncludingFallingPiece,
            """
                        🤍  🤍  💜  🤍  🤍
                        🤍  🤍  🤍  🤍  🤍
                        🤍  🤍  🤍  🤍  🤍
                        🤍  🤍  🤍  🤍  🤍
                        🤍  🤍  🤍  🤍  🤍
                        """
        )
        
        board.movePieceDown()
        XCTAssertEqual(
            board.rowsIncludingFallingPiece,
            """
                        🤍  💜  💜  💜  🤍
                        🤍  🤍  💜  🤍  🤍
                        🤍  🤍  🤍  🤍  🤍
                        🤍  🤍  🤍  🤍  🤍
                        🤍  🤍  🤍  🤍  🤍
                        """
        )
        
        board.movePieceDown()
        XCTAssertEqual(
            board.rowsIncludingFallingPiece,
            """
                        🤍  🤍  🤍  🤍  🤍
                        🤍  💜  💜  💜  🤍
                        🤍  🤍  💜  🤍  🤍
                        🤍  🤍  🤍  🤍  🤍
                        🤍  🤍  🤍  🤍  🤍
                        """
        )
    
        XCTAssertNoThrow(try board.movePieceLeft())
        XCTAssertEqual(
            board.rowsIncludingFallingPiece,
            """
                        🤍  🤍  🤍  🤍  🤍
                        💜  💜  💜  🤍  🤍
                        🤍  💜  🤍  🤍  🤍
                        🤍  🤍  🤍  🤍  🤍
                        🤍  🤍  🤍  🤍  🤍
                        """
        )
        
        XCTAssertThrowsSpecificError(
            try board.movePieceLeft(),
            expectedError: Board.Error.cannotMoveLeftIsAtEdge
        )
    }
    
}

extension XCTestCase {
    func XCTAssertThrowsSpecificError<T, Error>(
        _ expression: @autoclosure () throws -> T,
        expectedError: Error,
        _ message: @autoclosure () -> String = "",
        file: StaticString = #filePath,
        line: UInt = #line
    ) where Error: Swift.Error & Equatable {
        XCTAssertThrowsError(try expression(), message(), file: file, line: line) { anyError in
            guard let error = anyError as? Error else {
                XCTFail("Wrong error type, expected type \(Error.self), but got: \(type(of: anyError))", file: file, line: line)
                return
            }
            XCTAssertEqual(expectedError, error, message(), file: file, line: line)
        }
    }
}
