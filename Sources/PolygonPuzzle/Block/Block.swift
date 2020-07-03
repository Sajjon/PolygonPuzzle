//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2020-07-03.
//

import Foundation

/// The differently shaped and colored falling blocks that we need to fit into our already
/// fallen blocks to form solid rows.
///
/// - Tag: Block
public enum Block: Hashable, CaseIterable {
    
    /// `O` block with [yellow fill](x-source-tag://Fill.yellow) squares.
    ///
    /// - Tag: Block.o
    case oBlock
    
    /// `I` block with [teal fill](x-source-tag://Fill.teal) squares.
    ///
    /// - Tag: Block.i
    case iBlock
    
    /// `Z` block with [red fill](x-source-tag://Fill.red) squares.
    ///
    /// - Tag: Block.z
    case zBlock
    
    /// `S` block with [green fill](x-source-tag://Fill.green) squares.
    ///
    /// - Tag: Block.s
    case sBlock
    
    /// `L` block with [orange fill](x-source-tag://Fill.orange) squares.
    ///
    /// - Tag: Block.l
    case lBlock
    
    /// `J` block with [blue fill](x-source-tag://Fill.blue) squares.
    ///
    /// - Tag: Block.j
    case jBlock
    
    /// `T` block with [purple fill](x-source-tag://Fill.purple) squares.
    ///
    /// - Tag: Block.t
    case tBlock
}
