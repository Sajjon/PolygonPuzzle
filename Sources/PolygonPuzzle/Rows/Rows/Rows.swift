//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2020-07-02.
//

import Foundation

public struct Rows: Hashable, Collection, SquaresRepresentable {
    
    /// This minimum possible height of a rows,  one square higher then the height of a "veritcall" rotated `Block.iBlock`
    public static let minimumHeight = 5
    
    public var rows: [Row] {
        willSet {
            assert(newValue.count == height)
            newValue.forEach {
                assert($0.count == rowWidth)
            }
        }
    }
    
    public let rowWidth: Int
    public let height: Int
    
    public init(rows: [Row]) {
        var previousRowIndex = -1
        guard let row = rows.first, case let rowWidth = row.width else {
            fatalError("Rows cannot be empty")
        }
        precondition(rowWidth > 0)
        rows.forEach {
            let rowIndex = $0.index
            defer { previousRowIndex = rowIndex }
            precondition(rowIndex == (previousRowIndex + 1))
            precondition($0.width == rowWidth)
        }
        let height  = rows.count
        precondition(height >= Self.minimumHeight)
        self.rowWidth = rowWidth
        self.height = height
        self.rows = rows
    }
}

// MARK: Public
public extension Rows {
    init(
        count numberOfRows: Int = 20,
        ofWidth width: Int = 10
    ) {
        self.init(rows: (0..<numberOfRows).map { .init(at: $0, width: width) })
    }
    
}

// MARK: SquaresRepresentable
public extension Rows {
    var rowCount: Int {
        height
    }
    
    var squares: [Square] {
        var allSquares = [Square]()
        for row in self {
            for square in row {
                allSquares.append(square)
            }
        }
        return allSquares
    }
    
    func rowAtIndex(_ rowIndex: Int) -> Row {
        self[rowIndex]
    }
}

// MARK: Collection
public extension Rows {
    typealias Index = Array<Row>.Index
    typealias Iterator = Array<Row>.Iterator
    
    func makeIterator() -> Iterator {
        rows.makeIterator()
    }
    
    var startIndex: Index {
        rows.startIndex
    }
    
    var endIndex: Index {
        rows.endIndex
    }
    
    func index(after index: Index) -> Index {
        rows.index(after: index)
    }
    
    subscript(index: Index) -> Iterator.Element {
        get { rows[index] }
        set { rows[index] = newValue }
    }
}
