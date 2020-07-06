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
        fallingBlockRotation: BlockRotation = .random(),
        nextBlock: Block = Block.random(),
        rows: Rows,
        didScore: @escaping (Int) -> Void = { print("Did clear #\($0) rows") }
    ) {
        
        self.rowsExcludingFallingPiece = rows
        let width = rows[0].width
        
        self.fallingPiece = .init(
            block: fallingBlock,
            rotation: fallingBlockRotation,
            centerInColumn: width/2
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
            rotation: .identity,
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
}
