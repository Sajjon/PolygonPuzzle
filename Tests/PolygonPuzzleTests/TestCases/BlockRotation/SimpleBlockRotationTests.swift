//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2020-07-03.
//

import XCTest
@testable import PolygonPuzzle

final class SimpleBlockRotationTests: TestCase {

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
