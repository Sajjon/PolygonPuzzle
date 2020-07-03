//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2020-07-03.
//

import Foundation

public extension Tile {
    
    /// The fill of [Block](x-source-tag://Board.Block)s each block has a different one.
    ///
    /// The `rawValue` represents the color (on hex format) for the filll.
    enum Fill: Int, Hashable, CaseIterable {
        
        /// The fill of the [`O` block](x-source-tag://Block.o)
        ///
        /// - Tag: Fill.yellow
        case yellow = 0xFECB00
        
        /// The fill of the [`I` block](x-source-tag://Block.i)
        ///
        /// - Tag: Fill.teal
        case teal = 0x009FDA
        
        /// The fill of the [`Z` block](x-source-tag://Block.z)
        ///
        /// - Tag: Fill.red
        case red = 0xED2939
        
        /// The fill of the [`S` block](x-source-tag://Block.s)
        ///
        /// - Tag: Fill.green
        case green = 0x69BE28
        
        /// The fill of the [`L` block](x-source-tag://Block.l)
        ///
        /// - Tag: Fill.orange
        case orange = 0xFF7900
        
        /// The fill of the [`J` block](x-source-tag://Block.j)
        ///
        /// - Tag: Fill.blue
        case blue = 0x0065BD
        
        /// The fill of the [`T` block](x-source-tag://Block.t)
        ///
        /// - Tag: Fill.purple
        case purple = 0x952D98
    }
}
