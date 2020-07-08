//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2020-07-06.
//

import Foundation

public extension CaseIterable {
    static func random() -> Self {
        Self.allCases.randomElement()!
    }
}

public struct Board: Equatable {
    public private(set) var fallingPiece: FallingPiece
    public private(set) var nextBlock: Block
    private var rowsExcludingFallingPiece: Rows
    private let didScore: (Int) -> Void
    public let width: Int
    public let height: Int
    
    public init(
        fallingBlock: Block = .random(),
        fallingBlockRotation: RotationState = .random(),
        nextBlock: Block = Block.random(),
        rows: Rows,
        didScore: @escaping (Int) -> Void = { print("Did clear #\($0) rows") }
    ) {
        
        self.rowsExcludingFallingPiece = rows
        let width = rows[0].width
        
        self.fallingPiece = .init(
            block: fallingBlock,
            rotationState: fallingBlockRotation,
            centerInColumn: width/2
        )
        
        self.nextBlock = nextBlock
        self.didScore = didScore
        self.width = width
        self.height = rows.count
    }
    
    public init(
        fallingBlock: Block = .random(),
        fallingBlockRotation: RotationState = .random(),
        nextBlock: Block = Block.random(),
        numberOfRows: Int = 20,
        ofWidth rowWidth: Int = 10,
        didScore: @escaping (Int) -> Void = { print("Did clear #\($0) rows") }
    ) {
        self.init(
            fallingBlock: fallingBlock,
            fallingBlockRotation: fallingBlockRotation,
            nextBlock: nextBlock,
            rows: .init(count: numberOfRows, ofWidth: rowWidth),
            didScore: didScore
        )
    }
}

public extension Board {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.rowsIncludingFallingPiece == rhs.rowsIncludingFallingPiece
    }
}

private extension Board {
    mutating func nextPiece() {
        fallingPiece = .init(
            block: nextBlock,
            rotationState: .identity,
            centerInColumn: width/2
        )
        nextBlock = Block.random()
    }
    
    mutating func updateRows() {
        let result = rowsExcludingFallingPiece.reduce(inlaying: fallingPiece)
        switch result {
        case .contact(let numberOfRowsClearedIfAny):
            // This WILL have edit `rows`
            didScore(numberOfRowsClearedIfAny)
        case .noContact(
            let rowsIncludingFallingPiece,
            let isPieceInFrame
        ):
            print("no contact - isPieceInFrame: \(isPieceInFrame)")
        }
    }
}

public extension Board {
    
    var rowsIncludingFallingPiece: Rows {
        do {
            let result = try Rows.reduce(state: rowsExcludingFallingPiece, inlaying: fallingPiece).get()
            switch result {
            case .contact:
                return rowsExcludingFallingPiece
            case .noContact(_, let rowsIncludingFallingPiece):
                return rowsIncludingFallingPiece
            case .pieceNotInFrame(let rowsIncludingFallingPiece):
                return rowsIncludingFallingPiece
            }
        } catch {
            unexpectedlyCaught(error: error)
        }
    }
    
    enum Error: Swift.Error {
        case cannotMoveLeftIsAtEdge
        case cannotMoveRightIsAtEdge
    }
    
    mutating func movePieceDown() {
        fallingPiece.moveDown()
        updateRows()
    }
    
    mutating func movePieceLeft() throws {
        do {
            try fallingPiece.moveLeft()
            updateRows()
        } catch FallingPiece.Error.cannotMoveLeftIsAtEdge {
            throw Error.cannotMoveLeftIsAtEdge
        } catch {
            unexpectedlyCaught(error: error)
        }
    }
    
    mutating func movePieceRight() throws {
        if fallingPiece.rightMostFilledSquare.columnIndex == width - 1 {
            throw Error.cannotMoveRightIsAtEdge
        }
        fallingPiece.moveRight()
        updateRows()
    }
    
    /// Tries to rotate the falling piece π ½ radians either clockwise or counter clockwise.
    ///
    /// The rotationState is using [SRS rotationState rules][SRS]. Below is an exerpt of those rules.
    ///
    /// # Basic rotationState
    /// The basic rotationState states are shown in block in [J](x-source-tag://Block), things to note:
    ///
    /// - When unobstructed, the blocks all appear to rotate purely about a single point,
    /// this point can be found by looking at the 4 different rotations of each [block](x-source-tag://Block),
    /// where `R` denotes this rotatio point (axis).
    /// - It is a pure rotationState in a mathematical sense, as opposed to the combination of rotationState
    /// and translation found in other systems such as Sega Rotation and Atari Rotation.
    /// - As a direct consequence, the [J](x-source-tag://Block.j), [L](x-source-tag://Block.l),
    /// [S](x-source-tag://Block.s), [T](x-source-tag://Block.t) and [Z](x-source-tag://Block.z)
    /// blocks have 1 of their 4 rotations in a "floating" position where they are not in contact
    /// with the bottom of their bounding box.
    /// - This allows the bounding box to descend below the floor of the playing field making it
    /// impossible for the blocks to be rotated without the aid of "floor kicks".
    /// - The [S](x-source-tag://Block.s), [Z](x-source-tag://Block.z) and [I](x-source-tag://Block.i)
    /// blocks have two horizontally oriented states and two vertically oriented states. It can
    /// be argued that having two vertical states leads to faster finesse.
    /// - For the [I](x-source-tag://Block.i) and [O](x-source-tag://Block.o) blocks,
    /// the apparent rotationState center is at the intersection of gridlines, whereas for the other blocks,
    /// the rotationState center coincides with the center of one of the four constituent squares.
    ///
    /// # Wall Kicks
    /// When the player attempts to rotate a block, but the position it would normally occupy
    /// after basic rotationState is obstructed, (either by the wall or floor of the playfield, or by the stack),
    /// the game will attempt to "kick" the block into an alternative position nearby. Some points to note:
    ///
    /// - When a rotationState is attempted, 5 positions are sequentially tested (inclusive of basic rotationState)
    /// if none are available, the rotationState fails completely.
    /// - Which positions are tested is determined by the initial rotationState state, and the desired
    /// final rotationState state. Because it is possible to rotate both clockwise and counter-clockwise,
    /// for each of the 4 initial states there are 2 final states. Therefore there are a total of 8
    /// possible rotations for each tetromino and 8 sets of wall kick data need to be described.
    /// - The positions are commonly described as a sequence of ( x, y) kick values representing
    /// translations relative to basic rotationState; a convention of positive x rightwards, positive y
    /// upwards is used, e.g. (-1,+2) would indicate a kick of 1 cell left and 2 cells up.
    /// - The J, L, S, T and Z blocks all share the same kick values, the I tetromino has its own set of kick values, and the O tetromino does not kick.
    /// - Several different conventions are commonly used for the naming of the rotationState states. On this page, the following convention will be used:
    ///
    /// [SRS]: https://harddrop.com/wiki/SRS
    ///
    mutating func rotatePiece(rotationState: Rotation = .clockwise) throws {
        implementMe()
    }
    
}
