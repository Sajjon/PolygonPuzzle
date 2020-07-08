//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2020-07-08.
//

import Foundation

/// SRS Rotation wall kick tests
///
/// # Wall Kicks
/// When the player attempts to rotate a block, but the position it would normally occupy
/// after basic rotation is obstructed, (either by the wall or floor of the playfield, or by the stack),
/// the game will attempt to "kick" the block into an alternative position nearby. Some points to note:
///
/// - When a rotation is attempted, 5 positions are sequentially tested (inclusive of basic rotation)
/// if none are available, the rotation fails completely.
/// - Which positions are tested is determined by the initial rotation state, and the desired
/// final rotation state. Because it is possible to rotate both clockwise and counter-clockwise,
/// for each of the 4 initial states there are 2 final states. Therefore there are a total of 8
/// possible rotations for each tetromino and 8 sets of wall kick data need to be described.
/// - The positions are commonly described as a sequence of ( x, y) kick values representing
/// translations relative to basic rotation; a convention of positive x rightwards, positive y
/// upwards is used, e.g. (-1,+2) would indicate a kick of 1 cell left and 2 cells up.
/// - The J, L, S, T and Z blocks all share the same kick values, the I tetromino has its own
/// set of kick values, and the O tetromino does not kick.
/// - Several different conventions are commonly used for the naming of the rotation states.
/// On this page, the following convention will be used:
///
public enum WallKickTests {
    
    public static let testCount = 5
    
    static func wallKickTest(piece: FallingPiece, rows: Rows, rotation: Rotation) throws -> Bool {
        implementMe()
    }
    
//    static func wallKickTestCoordinates(
//        piece: FallingPiece,
//        rotation: Rotation
//    ) -> [Coordinate] {
//        wallKickTestCoordinates(block: piece.block, blockRotation: piece.rotation, rotationState: rotationState)
//    }
    
    static func wallKickTestCoordinates(
        block: Block,
        rotationState: RotationState,
        rotation: Rotation
    ) -> [Coordinate] {
        let nextRotationState = rotationState.rotated(rotation: rotation)
        precondition(nextRotationState != rotationState)
        
        return wallKickTestCoordinates(
            block: block,
            rotationState: rotationState,
            nextRotationState: nextRotationState
        )
    }
    
    static func wallKickTestCoordinates(
        block: Block,
        rotationState: RotationState,
        nextRotationState: RotationState
    ) -> [Coordinate] {
        
        func coordinateAllButBlockI() -> [Coordinate] {
            precondition(block != .iBlock)
            
            var coordinates = [Coordinate]()
            switch (rotationState, nextRotationState) {
            
            /// `0 -> R`
            case (.identity, .idπ½Clockwise):
                coordinates = [
                    .zero,
                    .init(x: -1, y: 0),
                    .init(x: -1, y: 1),
                    .init(x: 0, y: -2),
                    .init(x: -1, y: -2)
                ]
                
            /// `R -> 0`
            case (.idπ½Clockwise, .identity):
                coordinates = [
                    .zero,
                    .init(x: 1, y: 0),
                    .init(x: 1, y: -1),
                    .init(x: 0, y: 2),
                    .init(x: 1, y: 2)
                ]
                
            /// `R -> 2`
            case (.idπ½Clockwise, .idπClockwise):
                coordinates = [
                    .zero,
                    .init(x: 1, y: 0),
                    .init(x: 1, y: -1),
                    .init(x: 0, y: 2),
                    .init(x: 1, y: 2)
                ]
                
            /// `2 -> R`
            case (.idπClockwise, .idπ½Clockwise):
                coordinates = [
                    .zero,
                    .init(x: -1, y: 0),
                    .init(x: -1, y: 1),
                    .init(x: 0, y: -2),
                    .init(x: -1, y: -2)
                ]
                
            /// `2 -> L`
            case (.idπClockwise, .id3π½Clockwise):
                coordinates = [
                    .zero,
                    .init(x: 1, y: 0),
                    .init(x: 1, y: 1),
                    .init(x: 0, y: -2),
                    .init(x: 1, y: -2)
                ]
                
            /// `L -> 2`
            case (.id3π½Clockwise, .idπClockwise):
                coordinates = [
                    .zero,
                    .init(x: -1, y: 0),
                    .init(x: -1, y: -1),
                    .init(x: 0, y: 2),
                    .init(x: -1, y: 2)
                ]
                
            /// `L -> 0`
            case (.id3π½Clockwise, .identity):
                coordinates = [
                    .zero,
                    .init(x: -1, y: 0),
                    .init(x: -1, y: -1),
                    .init(x: 0, y: 2),
                    .init(x: -1, y: 2)
                ]
                
            /// `0 -> L`
            case (.identity, .id3π½Clockwise):
                coordinates = [
                    .zero,
                    .init(x: 1, y: 0),
                    .init(x: 1, y: 1),
                    .init(x: 0, y: -2),
                    .init(x: 1, y: -2)
                ]
                
            default: incorrectImplementation(reason: "Should have handled all rotations")
            }
            
            return coordinates
        }
        
        func coordinateOnlyIBlock() -> [Coordinate] {
            precondition(block == .iBlock)
            
            var coordinates = [Coordinate]()
            
            switch (rotationState, nextRotationState) {
            
            /// `0 -> R`
            case (.identity, .idπ½Clockwise):
                coordinates = [
                    .zero,
                    .init(x: -2, y: 0),
                    .init(x: 1, y: 0),
                    .init(x: -2, y: -1),
                    .init(x: 1, y: 2)
                ]
                
            /// `R -> 0`
            case (.idπ½Clockwise, .identity):
                coordinates = [
                    .zero,
                    .init(x: 2, y: 0),
                    .init(x: -1, y: 0),
                    .init(x: 2, y: 1),
                    .init(x: -1, y: -2)
                ]
                
            /// `R -> 2`
            case (.idπ½Clockwise, .idπClockwise):
                coordinates = [
                    .zero,
                    .init(x: -1, y: 0),
                    .init(x: 2, y: 0),
                    .init(x: -1, y: 2),
                    .init(x: 2, y: -1)
                ]
                
            /// `2 -> R`
            case (.idπClockwise, .idπ½Clockwise):
                coordinates = [
                    .zero,
                    .init(x: 1, y: 0),
                    .init(x: -2, y: 0),
                    .init(x: 1, y: -2),
                    .init(x: -2, y: 1)
                ]
                
            /// `2 -> L`
            case (.idπClockwise, .id3π½Clockwise):
                coordinates = [
                    .zero,
                    .init(x: 2, y: 0),
                    .init(x: -1, y: 0),
                    .init(x: 2, y: 1),
                    .init(x: -1, y: -2)
                ]
                
            /// `L -> 2`
            case (.id3π½Clockwise, .idπClockwise):
                coordinates = [
                    .zero,
                    .init(x: -2, y: 0),
                    .init(x: 1, y: 0),
                    .init(x: -2, y: -1),
                    .init(x: 1, y: 2)
                ]
                
            /// `L -> 0`
            case (.id3π½Clockwise, .identity):
                coordinates = [
                    .zero,
                    .init(x: 1, y: 0),
                    .init(x: -2, y: 0),
                    .init(x: 1, y: -2),
                    .init(x: -2, y: 1)
                ]
                
            /// `0 -> L`
            case (.identity, .id3π½Clockwise):
                coordinates = [
                    .zero,
                    .init(x: -1, y: 0),
                    .init(x: 2, y: 0),
                    .init(x: -1, y: 2),
                    .init(x: 2, y: -1)
                ]
                
            default: incorrectImplementation(reason: "Should have handled all rotations")
            }
            return coordinates
        }
        
        let coordinates = block == .iBlock ? coordinateOnlyIBlock() : coordinateAllButBlockI()
        assert(coordinates.count == testCount)
        return coordinates
    }
}

