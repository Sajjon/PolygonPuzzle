//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2020-07-02.
//

import Foundation

public struct Rows: Hashable, Collection, ExpressibleByArrayLiteral {
    
    private var rows: [Row]
    
    public init(
        count numberOfRows: Int = 20,
        ofWidth width: Int = 10
    ) {
        self.init(rows: (0..<numberOfRows).map { .init(at: $0, width: width) })
    }
    
    public init(rows: [Row]) {
        guard let row = rows.first, case let rowWidth = row.width else {
            fatalError("Rows cannot be empty")
        }
        rows.forEach {
            precondition($0.width == rowWidth)
        }
        self.rows = rows
    }
}

// MARK: Public
public extension Rows {
    mutating func clearRow(at indexToClear: Int) {
        precondition(indexToClear < rows.count)
        rows[indexToClear].clear()
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
    }
}
