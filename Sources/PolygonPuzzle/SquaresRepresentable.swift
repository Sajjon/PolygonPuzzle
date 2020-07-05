//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2020-07-03.
//

import Foundation

public protocol SquaresRepresentable: CustomStringConvertible {
    var rowWidth: Int { get }
    var rowCount: Int { get }
    func rowAtIndex(_ rowIndex: Int) -> Row
    func columnAtIndex(_ columnIndex: Int) -> Column
    var squares: [Square] { get }
}

public enum Edge {
    case top, bottom, left, right
}

public extension SquaresRepresentable {
    
    func topMostFilledSquareInColumn(_ columnIndex: Int) -> Square? {
        let column = columnAtIndex(columnIndex)
        let filledSquares = column.squares.filter { $0.isFilled }
        return filledSquares.min(by: \.rowIndex)
    }
    
    func columnAtIndex(_ columnIndex: Int) -> Column {
        var squaresInColumn = [Square]()
        for rowIndex in 0..<rowCount {
            let row = rowAtIndex(rowIndex)
            guard
                case let squaresMatchingColumnIndex = row.squares.filter({ $0.columnIndex == columnIndex }),
                squaresMatchingColumnIndex.count == 1,
                let squareMatchingColumnIndex = squaresMatchingColumnIndex.first
            else {
                incorrectImplementation(reason: "A row should contain squares with unique columns")
            }
            squaresInColumn.append(squareMatchingColumnIndex)
        }
        
        return Column(squares: squaresInColumn)
    }
    
    func firstFilledSquareFromEdge(_ edge: Edge) -> Square {
        switch edge {
        case .top: return topMostFilledSquare
        case .bottom: return bottomMostFilledSquare
        case .left: return leftMostFilledSquare
        case .right: return rightMostFilledSquare
        }
    }
    
    var leftMostFilledSquare: Square {
        guard let leftMostSquare = filledSquares.min(by: \.columnIndex) else {
            incorrectImplementation(shouldAlwaysBeAbleTo: "Get leftmost square")
        }
        return leftMostSquare
    }
    
    var rightMostFilledSquare: Square {
        guard let rightMostSquare = filledSquares.max(by: \.columnIndex) else {
            incorrectImplementation(shouldAlwaysBeAbleTo: "Get rightmost square")
        }
        return rightMostSquare
    }
    
    var bottomMostFilledSquare: Square {
        guard let bottomMostSquare = filledSquares.max(by: \.rowIndex) else {
            incorrectImplementation(shouldAlwaysBeAbleTo: "Get bottom most square")
        }
        return bottomMostSquare
    }
    
    var topMostFilledSquare: Square {
        guard let topMostFilledSquare = filledSquares.min(by: \.rowIndex) else {
            incorrectImplementation(shouldAlwaysBeAbleTo: "Get top most square")
        }
        return topMostFilledSquare
    }
    
   
    var filledSquares: [Square] {
        squares.filter { $0.isFilled }
    }
    
    var bottomMostFilledSquaresPerColumn: [Square] {
        Dictionary(
            grouping: filledSquares,
            by: { $0.columnIndex }
        )
             .sorted(by: { $0.key < $1.key }) // sort by `columnIndex`
        .map { kv -> Square in
            let column: [Square] = kv.value
            guard let bottomMostSquare = column.max(by: \.rowIndex) else {
                incorrectImplementation(reason: "Expected square")
            }
            return bottomMostSquare
        }
    }
    
    var bottomMostRowIndex: Int {
        rowCount - 1
    }
    
    var bottomMostRow: Row {
//        rows[bottomMostRowIndex]
        implementMe()
    }
}

// MARK: CustomStringConvertible
public extension SquaresRepresentable {
    
    func stringRepresentation(
        includeEmptySquares: Bool = true,
        showRowIndex: Bool = false,
        showColumnIndex: Bool = false
    ) -> String {
        
        let sortedSquares = Dictionary(
            grouping: includeEmptySquares ? self.squares : self.filledSquares,
            by: { $0.rowIndex }
        )
        .sorted(by: { $0.key < $1.key }) // sort by `rowIndex`
            
       let rowsStringWithoutAnnotation = sortedSquares
            .map { (rowIndex, row) in
                let rowString = row.map{ "\($0)" }.joined()
                guard showRowIndex else { return rowString }
                return "\(rowIndex)| \(rowString)"
            }
            .joined(separator: "\n")
        
        let rowAnnotation = ["⤒", "Row index", "\n"].joined(separator: "\n")
        let rowsString = showRowIndex ? [rowsStringWithoutAnnotation, rowAnnotation].joined(separator:"\n") : rowsStringWithoutAnnotation
        
        guard showColumnIndex else {
            return rowsString
        }
        
        let leadingSpace = showRowIndex ? "🧩" : ""
        let widestColumn = sortedSquares.map({ $0.value }).max(by: { $0.count > $1.count})!
        let columnRowWithoutLeadingSpace = widestColumn.map({ "\($0.columnIndex)" }).joined(separator: " |  ")
        let columnRow = leadingSpace + columnRowWithoutLeadingSpace + "\t ⟵ Column index"
        let spacerRow = String(repeating: "-", count: Int(Double(widestColumn.count + 1) * 3.5))
        
        return [
            columnRow,
            spacerRow,
            rowsString
        ].joined(separator: "\n")
    }
    
    var description: String {
        [
            "\n",
            stringRepresentation(),
            "\n"
        ].joined()
        
    }
}


public extension Square {
    func columnOrRowKeyPath(edge: Edge) -> KeyPath<Self, Int> {
        switch edge {
        case .left, .right: return \.columnIndex
        case .top, .bottom: return \.rowIndex
        }
    }
}
