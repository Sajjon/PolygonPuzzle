//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2020-07-03.
//

import Foundation

public extension Tile {
    
    /// A value represention the fill of [Block](x-source-tag://Board.Block)s each block has a different one.
    enum Fill: Int, Hashable, CaseIterable {
        
        /// The fill of the [`O` block](x-source-tag://Block.o)
        ///
        /// - Tag: Fill.o
        case oBlockFill = 1
        
        /// The fill of the [`I` block](x-source-tag://Block.i)
        ///
        /// - Tag: Fill.i
        case iBlockFill = 2
        
        /// The fill of the [`Z` block](x-source-tag://Block.z)
        ///
        /// - Tag: Fill.z
        case zBlockFill = 3
        
        /// The fill of the [`S` block](x-source-tag://Block.s)
        ///
        /// - Tag: Fill.s
        case sBlockFill = 4
        
        /// The fill of the [`L` block](x-source-tag://Block.l)
        ///
        /// - Tag: Fill.l
        case lBlockFill = 5
        
        /// The fill of the [`J` block](x-source-tag://Block.j)
        ///
        /// - Tag: Fill.j
        case jBlockFill = 6
        
        /// The fill of the [`T` block](x-source-tag://Block.t)
        ///
        /// - Tag: Fill.t
        case tBlockFill = 7
        public static let maxRawValue = Fill.tBlockFill.rawValue
    }
}
