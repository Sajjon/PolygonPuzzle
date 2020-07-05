//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2020-07-02.
//

import Foundation

public struct Rows: Hashable, Collection, ExpressibleByArrayLiteral {
    
    
    /// This minimum possible height of a rows, equal to the height of the `Block.iBlock`
    public static let minimumHeight = 4
    
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
        guard let row = rows.first, case let rowWidth = row.width else {
            fatalError("Rows cannot be empty")
        }
        precondition(rowWidth > 0)
        rows.forEach {
            precondition($0.width == rowWidth)
        }
        let height  = rows.count
        precondition(height >= Self.minimumHeight)
        self.rowWidth = rowWidth
        self.height = height
        self.rows = rows
    }
}

public extension Rows {
    init(
        count numberOfRows: Int = 20,
        ofWidth width: Int = 10
    ) {
        self.init(rows: (0..<numberOfRows).map { .init(at: $0, width: width) })
    }
    
}

// MARK: ExpressibleByArrayLiteral
public extension Rows {
    typealias ArrayLiteralElement = Row
    init(arrayLiteral rows: Row...) {
        self.init(rows: rows)
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
