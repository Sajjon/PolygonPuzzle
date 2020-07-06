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
    public private(set) var rows: Rows
    private let didScore: (Int) -> Void
    public let width: Int
    public let height: Int
    
    public init(
        fallingBlock: Block = .random(),
        fallingBlockRotation: BlockRotation = .random(),
        nextBlock: Block = Block.random(),
        rows: Rows,
        didScore: @escaping (Int) -> Void = { print("Did clear #\($0) rows") }
    ) {
        
        self.rows = rows
        let width = rows[0].width
        
        self.fallingPiece = .init(
            block: fallingBlock,
            rotation: fallingBlockRotation,
            column: width/2
        )
        
        self.nextBlock = nextBlock
        self.didScore = didScore
        self.width = width
        self.height = rows.count
    }
    
    public init(
        fallingBlock: Block = .random(),
        fallingBlockRotation: BlockRotation = .random(),
        nextBlock: Block = Block.random(),
        count numberOfRows: Int = 20,
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
        lhs.rows == rhs.rows && lhs.fallingPiece == rhs.fallingPiece
    }
}

private extension Board {
    mutating func nextPiece() {
        fallingPiece = .init(
            block: nextBlock,
            rotation: .identity,
            column: width/2
        )
        nextBlock = Block.random()
    }
    
}

public extension Board {
    
    enum Error: Swift.Error {
        case cannotMoveLeftIsAtEdge
        case cannotMoveRightIsAtEdge
    }
    
    mutating func moveDown() {
        fallingPiece.moveDown()
    }
    
    mutating func moveLeft() throws {
        do {
            try fallingPiece.moveLeft()
        } catch FallingPiece.Error.cannotMoveLeftIsAtEdge {
            throw Error.cannotMoveLeftIsAtEdge
        } catch {
            unexpectedlyCaught(error: error)
        }
    }
    
    mutating func moveRight() throws {
        if fallingPiece.rightMostFilledSquare.columnIndex == rows.rightMostColumnIndex {
            throw Error.cannotMoveRightIsAtEdge
        }
        fallingPiece.moveRight()
    }
}
