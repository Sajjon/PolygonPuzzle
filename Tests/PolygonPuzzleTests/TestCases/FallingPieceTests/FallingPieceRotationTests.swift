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
        let board = Board(
            fallingBlock: .tBlock,
            fallingBlockRotation: .idπClockwise,
            nextBlock: .jBlock,
            rows: """
                        🤍  🤍  🤍  🤍  🤍
                        🤍  🤍  🤍  🤍  🤍
                        🤍  🤍  🤍  🤍  🤍
                        🤍  🤍  🤍  🤍  🤍
                        🤍  🤍  🤍  🤍  🤍
                        """
        )
        
        XCTAssertEqual(board.fallingPiece.block, .tBlock)
        XCTAssertEqual(board.fallingPiece.rotation, .idπClockwise)
        XCTAssertEqual(board.nextBlock, .jBlock)
        XCTAssertEqual(board.height, 5)
        XCTAssertEqual(board.width, 5)
    }
    
}
