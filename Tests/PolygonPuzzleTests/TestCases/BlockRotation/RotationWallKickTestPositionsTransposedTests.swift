//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2020-07-08.
//

import Foundation
import XCTest
@testable import PolygonPuzzle

/// Performing a transpose on wall kick positions and tests those
final class RotationWallKickTestPositionsTransposedTests: TestCase {
    
    func test_block_non_i() {
        
        func doTestBlock(_ block: Block ) {
            func doTest(index: Int, expectedCoordinates: [Coordinate]) {
                precondition(expectedCoordinates.count == expliticRotations.count)
                
                func doInnerTest(_ testVector: ExplicitRotation, _ expected: Coordinate) {
                    let actual = WallKickTests.wallKickTestCoordinates(
                        block: block,
                        rotationState: testVector.from,
                        nextRotationState: testVector.to
                    )[index]
                    
                    XCTAssertEqual(expected, actual)
                }
                zip(
                    expliticRotations,
                    expectedCoordinates
                ).forEach(doInnerTest)
            }
            
            doTest(
                index: 0,
                expectedCoordinates: [Coordinate](repeating: .zero, count: expliticRotations.count)
            )
            
            doTest(
                index: 1,
                expectedCoordinates: [
                    .init(x: -1, y: 0),
                    .init(x: 1, y: 0),
                    .init(x: 1, y: 0),
                    .init(x: -1, y: 0),
                    .init(x: 1, y: 0),
                    .init(x: -1, y: 0),
                    .init(x: -1, y: 0),
                    .init(x: 1, y: 0)
                ]
            )
            
            doTest(
                index: 2,
                expectedCoordinates: [
                    .init(x: -1, y: 1),
                    .init(x: 1, y: -1),
                    .init(x: 1, y: -1),
                    .init(x: -1, y: 1),
                    .init(x: 1, y: 1),
                    .init(x: -1, y: -1),
                    .init(x: -1, y: -1),
                    .init(x: 1, y: 1)
                ]
            )
            
            doTest(
                index: 3,
                expectedCoordinates: [
                    .init(x: 0, y: -2),
                    .init(x: 0, y: 2),
                    .init(x: 0, y: 2),
                    .init(x: 0, y: -2),
                    .init(x: 0, y: -2),
                    .init(x: 0, y: 2),
                    .init(x: 0, y: 2),
                    .init(x: 0, y: -2)
                ]
            )
            
            doTest(
                index: 4,
                expectedCoordinates: [
                    .init(x: -1, y: -2),
                    .init(x: 1, y: 2),
                    .init(x: 1, y: 2),
                    .init(x: -1, y: -2),
                    .init(x: 1, y: -2),
                    .init(x: -1, y: 2),
                    .init(x: -1, y: 2),
                    .init(x: 1, y: -2)
                ]
            )
        }
        Block.allCases.filter({ $0 != .iBlock }).forEach(doTestBlock)
    }
    
    func test_block_i() {
        
        func doTest(index: Int, expectedCoordinates: [Coordinate]) {
            precondition(expectedCoordinates.count == expliticRotations.count)
            
            func doInnerTest(_ testVector: ExplicitRotation, _ expected: Coordinate) {
                let actual = WallKickTests.wallKickTestCoordinates(
                    block: .iBlock,
                    rotationState: testVector.from,
                    nextRotationState: testVector.to
                )[index]
                
                XCTAssertEqual(expected, actual)
            }
            zip(
                expliticRotations,
                expectedCoordinates
            ).forEach(doInnerTest)
        }
        
        doTest(
            index: 0,
            expectedCoordinates: [Coordinate](repeating: .zero, count: expliticRotations.count)
        )
        
        doTest(
            index: 1,
            expectedCoordinates: [
                .init(x: -2, y: 0),
                .init(x: 2, y: 0),
                .init(x: -1, y: 0),
                .init(x: 1, y: 0),
                .init(x: 2, y: 0),
                .init(x: -2, y: 0),
                .init(x: 1, y: 0),
                .init(x: -1, y: 0)
            ]
        )
        
        doTest(
            index: 2,
            expectedCoordinates: [
                .init(x: 1, y: 0),
                .init(x: -1, y: 0),
                .init(x: 2, y: 0),
                .init(x: -2, y: 0),
                .init(x: -1, y: 0),
                .init(x: 1, y: 0),
                .init(x: -2, y: 0),
                .init(x: 2, y: 0)
            ]
        )
        
        doTest(
            index: 3,
            expectedCoordinates: [
                .init(x: -2, y: -1),
                .init(x: 2, y: 1),
                .init(x: -1, y: 2),
                .init(x: 1, y: -2),
                .init(x: 2, y: 1),
                .init(x: -2, y: -1),
                .init(x: 1, y: -2),
                .init(x: -1, y: 2)
            ]
        )
        
        doTest(
            index: 4,
            expectedCoordinates: [
                .init(x: 1, y: 2),
                .init(x: -1, y: -2),
                .init(x: 2, y: -1),
                .init(x: -2, y: 1),
                .init(x: -1, y: -2),
                .init(x: 1, y: 2),
                .init(x: -2, y: 1),
                .init(x: 2, y: -1)
            ]
        )
    }
    
}

private extension RotationWallKickTestPositionsTransposedTests {
    
    struct ExplicitRotation {
        let from: RotationState
        let to: RotationState
    }
    
    var expliticRotations: [ExplicitRotation] {
        [
            /// `0 -> R`
            .init(from: .identity, to: .idπ½Clockwise),
            
            /// `R -> 0`
            .init(from: .idπ½Clockwise, to: .identity),
            
            /// `R -> 2`
            .init(from: .idπ½Clockwise, to: .idπClockwise),
            
            /// `2 -> R`
            .init(from: .idπClockwise, to: .idπ½Clockwise),
            
            /// `2 -> L`
            .init(from: .idπClockwise, to: .id3π½Clockwise),
            
            /// `L -> 2`
            .init(from: .id3π½Clockwise, to: .idπClockwise),
            
            /// `L -> 0`
            .init(from: .id3π½Clockwise, to: .identity),
            
            /// `0 -> L`
            .init(from: .identity, to: .id3π½Clockwise)
        ]
    }
}
