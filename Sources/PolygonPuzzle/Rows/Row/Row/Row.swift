//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2020-07-02.
//

import Foundation

public extension Rows {
    struct Row: Hashable, Collection {
        
        /// This minimum possible width of a row, equal to the size of the `Block.iBlock`
        public static let minimumWidth = 4
        
        /// Index from top of the board
        public let index: Int
        
        /// The width of the board, all rows in the board are expected to have the same width
        public let width: Int
        
        /// The squares/cells of this row, from left to right, equal number of elements as `width`
        private var squares: [Square]
        
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
}

public extension Rows.Row {
    mutating func clear() {
        squares = squares.map { $0.cleared() }
    }
}

// MARK: Collection
public extension Rows.Row {
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
    }
}

public extension Rows.Row {
    var isFilled: Bool {
        squares.allSatisfy { $0.isFilled }
    }
    
    var isEmpty: Bool {
        squares.allSatisfy { !$0.isFilled }
    }
}
