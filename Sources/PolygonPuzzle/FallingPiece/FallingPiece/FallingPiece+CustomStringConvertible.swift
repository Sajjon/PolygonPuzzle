//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2020-07-03.
//

import Foundation

extension Array {
    func sorted<Property>(
        by keyPath: KeyPath<Element, Property>,
        _ compare: (Property, Property) -> Bool
    ) -> [Element] where Property: Comparable {
        
        sorted(by: {
            compare($0[keyPath: keyPath], $1[keyPath: keyPath])
        })
    }
    
    func max<Property>(
        by keyPath: KeyPath<Element, Property>
    ) -> Element? where Property: Comparable {
        
        self.max(by: {
           $0[keyPath: keyPath] < $1[keyPath: keyPath]
        })
    }
    
    func min<Property>(
        by keyPath: KeyPath<Element, Property>
    ) -> Element? where Property: Comparable {
        
        self.min(by: {
           $0[keyPath: keyPath] < $1[keyPath: keyPath]
        })
    }

}

extension FallingPiece: CustomStringConvertible {
    
    func filledSquaresString(
        includeEmptySquares: Bool = true,
        showRowIndex: Bool = true,
        showColumnIndex: Bool = true
    ) -> String {
        
       let sortedSquares = Dictionary(grouping: squares(includeEmpty: includeEmptySquares), by: { $0.rowIndex })
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
    
    public var description: String {
        [
            "\n",
            filledSquaresString(),
            "\n"
        ].joined()
        
    }
}
