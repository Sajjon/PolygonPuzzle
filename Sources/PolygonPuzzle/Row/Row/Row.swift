//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2020-07-02.
//

import Foundation

public struct Row: Hashable, Collection, SquaresRepresentable {
    
    /// This minimum possible width of a row, equal to the size of the `Block.iBlock`
    public static let minimumWidth = 4
    
    /// Index from top of the board
    public let index: Int
    
    /// The width of the board, all rows in the board are expected to have the same width
    public let width: Int
    
    /// The squares/cells of this row, from left to right, equal number of elements as `width`
    public private(set) var squares: [Square]
    
    internal init(
        at index: Int,
        width: Int,
        squares: [Square]
    ) {
        precondition(width >= Self.minimumWidth)
        
        squares.forEach {
            assert($0.rowIndex == index)
        }
        assert(Set(squares.map { $0.columnIndex }).count == squares.count)
        self.index = index
        self.width = width
        self.squares = squares
    }
    
    public init(at index: Int, width: Int) {
        self.init(
            at: index,
            width: width,
            squares: (0..<width).map { .init(columnIndex: $0, rowIndex: index) }
        )
    }
}

// MARK: SquaresRepresentable
public extension Row {
    var rowWidth: Int {
        width
    }
    
    var rowCount: Int {
        1
    }
    
    func rowAtIndex(_ rowIndex: Int) -> Row {
        precondition(rowIndex == self.index, "Row index mismatch")
        return self
    }
}

// MARK: Collection
public extension Row {
    typealias Index = Array<Square>.Index
    typealias Iterator = Array<Square>.Iterator
    
    func makeIterator() -> Iterator {
        squares.makeIterator()
    }
    
    var startIndex: Index {
        squares.startIndex
    }
    
    var endIndex: Index {
        squares.endIndex
    }
    
    func index(after index: Index) -> Index {
        squares.index(after: index)
    }
    
    subscript(index: Index) -> Iterator.Element {
        get { squares[index] }
        set { squares[index] = newValue }
    }
}

public extension Row {
    var isFilled: Bool {
        squares.allSatisfy { $0.isFilled }
    }
    
    var isEmpty: Bool {
        squares.allSatisfy { !$0.isFilled }
    }
}
