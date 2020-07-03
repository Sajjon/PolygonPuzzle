//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2020-07-03.
//

import XCTest
@testable import PolygonPuzzle

final class FallingPieceStartingPositionTests: TestCase {
    
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
}
