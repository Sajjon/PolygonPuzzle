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
    
    // MARK: Block O
    
    /// `O` block with [yellow fill](x-source-tag://Fill.yellow) squares.
    ///
    /// # Rotation
    /// The `O` block is the only block which is completely identical for all 4 rotations.
    ///
    ///     *---------*---------*
    ///     |         |         |
    ///     |    A    |    B    |
    ///     |                   |
    ///     *-------- R --------*
    ///     |                   |
    ///     |    C    |     D   |
    ///     |         |         |
    ///     *---------*---------*
    ///
    /// - Tag: Block.o
    case oBlock
    
    
    // MARK: Block I
    
    /// `I` block with [teal fill](x-source-tag://Fill.teal) squares.
    ///
    /// # Rotations
    /// Below, let `R` marks the rotation center, and squares containing `#`
    /// are the filled ones.
    ///
    ///
    /// ## Identity
    ///     *---------*---------*---------*---------*
    ///     |         |         |         |         |
    ///     |    a    |    b    |    c    |    d    |
    ///     |         |         |         |         |
    ///     *---------*---------*---------*---------*
    ///     |#########|#########|#########|#########|
    ///     |### e ###|### f ###|### g ###|### h ###|
    ///     |#########|########   ########|#########|
    ///     *---------*-------  R  -------*---------*
    ///     |         |                   |         |
    ///     |    i    |    j    |    k    |    l    |
    ///     |         |         |         |         |
    ///     *---------*---------*---------*---------*
    ///     |         |         |         |         |
    ///     |    m    |    n    |    o    |    p    |
    ///     |         |         |         |         |
    ///     *---------*---------*---------*---------*
    /// A.k.a. no rotation at all.
    ///
    /// _,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,_
    ///
    /// ## Identity π½ Clockwise
    ///     *---------*---------*---------*---------*
    ///     |         |         |#########|         |
    ///     |    a    |    b    |    c    |    d    |
    ///     |         |         |#########|         |
    ///     *---------*---------*---------*---------*
    ///     |         |         |#########|         |
    ///     |    e    |    f    |### g ###|    h    |
    ///     |         |           ########|         |
    ///     *---------*-------  R  -------*---------*
    ///     |         |           ########|         |
    ///     |    i    |    j    |### k ###|    l    |
    ///     |         |         |#########|         |
    ///     *---------*---------*---------*---------*
    ///     |         |         |#########|         |
    ///     |    m    |    n    |### o ###|    p    |
    ///     |         |         |#########|         |
    ///     *---------*---------*---------*---------*
    /// (90° rotation of `identity` clockwise)
    ///
    /// _,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,_
    ///
    /// ## Identity π Clockwise
    ///     *---------*---------*---------*---------*
    ///     |         |         |         |         |
    ///     |    a    |    b    |    c    |    d    |
    ///     |         |         |         |         |
    ///     *---------*---------*---------*---------*
    ///     |         |         |         |         |
    ///     |    e    |    f    |    g    |    h    |
    ///     |         |                   |         |
    ///     *---------*-------  R  -------*---------*
    ///     |#########|#######    ########|#########|
    ///     |### i ###|### j ###|### k ###|### l ###|
    ///     |#########|#########|#########|#########|
    ///     *---------*---------*---------*---------*
    ///     |         |         |         |         |
    ///     |    m    |    n    |    o    |    p    |
    ///     |         |         |         |         |
    ///     *---------*---------*---------*---------*
    /// (180° rotation of `identity` clockwise)
    ///
    /// _,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,_
    ///
    /// ## Identity 3π½ Clockwise
    ///     *---------*---------*---------*---------*
    ///     |         |#########|         |         |
    ///     |    a    |    b    |    c    |    d    |
    ///     |         |#########|         |         |
    ///     *---------*---------*---------*---------*
    ///     |         |#########|         |         |
    ///     |    e    |### f ###|    g    |    h    |
    ///     |         |########           |         |
    ///     *---------*-------  R  -------*---------*
    ///     |         |########           |         |
    ///     |    i    |### j ###|    k    |    l    |
    ///     |         |#########|         |         |
    ///     *---------*---------*---------*---------*
    ///     |         |#########|         |         |
    ///     |    m    |### n ###|    o    |    p    |
    ///     |         |#########|         |         |
    ///     *---------*---------*---------*---------*
    /// (270° rotation of `identity` clockwise)
    ///
    /// - Tag: Block.i
    case iBlock
    
    // MARK: Block Z
    
    /// `Z` block with [red fill](x-source-tag://Fill.red) squares.
    ///
    /// # Rotations
    /// Below, let `R` marks the rotation center, and squares containing `#`
    /// are the filled ones.
    ///
    ///
    /// ## Identity
    ///     *---------*---------*---------*
    ///     |#########|#########|         |
    ///     |### a ###|### b ###|    c    |
    ///     |#########|#########|         |
    ///     *---------*---------*---------*
    ///     |         |#########|#########|
    ///     |    d    |## e R ##|### f ###|
    ///     |         |#########|#########|
    ///     *---------*---------*---------*
    ///     |         |         |         |
    ///     |    g    |    h    |    i    |
    ///     |         |         |         |
    ///     *---------*---------*---------*
    /// A.k.a. no rotation at all.
    ///
    /// _,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,_
    ///
    /// ## Identity π½ Clockwise
    ///     *---------*---------*---------*
    ///     |         |         |#########|
    ///     |    a    |    b    |### c ###|
    ///     |         |         |#########|
    ///     *---------*---------*---------*
    ///     |         |#########|#########|
    ///     |    d    |## e R ##|### f ###|
    ///     |         |#########|#########|
    ///     *---------*---------*---------*
    ///     |         |#########|         |
    ///     |    g    |### h ###|    i    |
    ///     |         |#########|         |
    ///     *---------*---------*---------*
    /// (90° rotation of `identity` clockwise)
    ///
    /// _,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,_
    ///
    /// ## Identity π Clockwise
    ///     *---------*---------*---------*
    ///     |         |         |         |
    ///     |    a    |    b    |    c    |
    ///     |         |         |         |
    ///     *---------*---------*---------*
    ///     |#########|#########|         |
    ///     |### d ###|### e R #|    f    |
    ///     |#########|#########|         |
    ///     *---------*---------*---------*
    ///     |         |#########|#########|
    ///     |    g    |### h ###|### i ###|
    ///     |         |#########|#########|
    ///     *---------*---------*---------*
    /// (180° rotation of `identity` clockwise)
    ///
    /// _,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,_
    ///
    /// ## Identity 3π½ Clockwise
    ///     *---------*---------*---------*
    ///     |         |#########|         |
    ///     |    a    |### b ###|    c    |
    ///     |         |#########|         |
    ///     *---------*---------*---------*
    ///     |#########|#########|         |
    ///     |### d ###|## e R ##|    f    |
    ///     |#########|#########|         |
    ///     *---------*---------*---------*
    ///     |#########|         |         |
    ///     |### g ###|    h    |    i    |
    ///     |#########|         |         |
    ///     *---------*---------*---------*
    /// (270° rotation of `identity` clockwise)
    ///
    /// - Tag: Block.z
    case zBlock
    
    // MARK: Block S
    
    /// `S` block with [green fill](x-source-tag://Fill.green) squares.
    ///
    /// # Rotations
    /// Below, let `R` marks the rotation center, and squares containing `#`
    /// are the filled ones.
    ///
    ///
    /// ## Identity
    ///     *---------*---------*---------*
    ///     |         |#########|#########|
    ///     |    a    |### b ###|### c ###|
    ///     |         |#########|#########|
    ///     *---------*---------*---------*
    ///     |#########|#########|         |
    ///     |### d ###|## e R ##|    f    |
    ///     |#########|#########|         |
    ///     *---------*---------*---------*
    ///     |         |         |         |
    ///     |    g    |    h    |    i    |
    ///     |         |         |         |
    ///     *---------*---------*---------*
    /// A.k.a. no rotation at all.
    ///
    /// _,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,_
    ///
    /// ## Identity π½ Clockwise
    ///     *---------*---------*---------*
    ///     |         |#########|         |
    ///     |    a    |### b ###|    c    |
    ///     |         |#########|         |
    ///     *---------*---------*---------*
    ///     |         |#########|#########|
    ///     |    d    |## e R ##|### f ###|
    ///     |         |#########|#########|
    ///     *---------*---------*---------*
    ///     |         |         |#########|
    ///     |    g    |    h    |### i ###|
    ///     |         |         |#########|
    ///     *---------*---------*---------*
    /// (90° rotation of `identity` clockwise)
    ///
    /// _,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,_
    ///
    /// ## Identity π Clockwise
    ///     *---------*---------*---------*
    ///     |         |         |         |
    ///     |    a    |    b    |    c    |
    ///     |         |         |         |
    ///     *---------*---------*---------*
    ///     |         |#########|#########|
    ///     |    d    |### e R #|### f ###|
    ///     |         |#########|#########|
    ///     *---------*---------*---------*
    ///     |#########|#########|         |
    ///     |### g ###|### h ###|    i    |
    ///     |#########|#########|         |
    ///     *---------*---------*---------*
    /// (180° rotation of `identity` clockwise)
    ///
    /// _,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,_
    ///
    /// ## Identity 3π½ Clockwise
    ///     *---------*---------*---------*
    ///     |#########|         |         |
    ///     |### a ###|    b    |    c    |
    ///     |#########|         |         |
    ///     *---------*---------*---------*
    ///     |#########|#########|         |
    ///     |### d ###|## e R ##|    f    |
    ///     |#########|#########|         |
    ///     *---------*---------*---------*
    ///     |         |#########|         |
    ///     |    g    |### h ###|    i    |
    ///     |         |#########|         |
    ///     *---------*---------*---------*
    /// (270° rotation of `identity` clockwise)
    ///
    /// - Tag: Block.s
    case sBlock
    
    // MARK:  Block L
    
    /// `L` block with [orange fill](x-source-tag://Fill.orange) squares.
    ///
    /// # Rotations
    /// Below, let `R` marks the rotation center, and squares containing `#`
    /// are the filled ones.
    ///
    ///
    /// ## Identity
    ///     *---------*---------*---------*
    ///     |         |#########|         |
    ///     |    a    |### b ###|    c    |
    ///     |         |#########|         |
    ///     *---------*---------*---------*
    ///     |         |#########|         |
    ///     |    d    |## e R ##|    f    |
    ///     |         |#########|         |
    ///     *---------*---------*---------*
    ///     |         |#########|#########|
    ///     |    g    |### h ###|### i ###|
    ///     |         |#########|#########|
    ///     *---------*---------*---------*
    /// A.k.a. no rotation at all.
    ///
    /// _,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,_
    ///
    /// ## Identity π½ Clockwise
    ///     *---------*---------*---------*
    ///     |         |         |         |
    ///     |    a    |    b    |    c    |
    ///     |         |         |         |
    ///     *---------*---------*---------*
    ///     |#########|#########|#########|
    ///     |### d ###|## e R ##|### f ###|
    ///     |#########|#########|#########|
    ///     *---------*---------*---------*
    ///     |#########|         |         |
    ///     |### g ###|    h    |    i    |
    ///     |#########|         |         |
    ///     *---------*---------*---------*
    /// (90° rotation of `identity` clockwise)
    ///
    /// _,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,_
    ///
    /// ## Identity π Clockwise
    ///     *---------*---------*---------*
    ///     |#########|#########|         |
    ///     |### a ###|### b ###|    c    |
    ///     |#########|#########|         |
    ///     *---------*---------*---------*
    ///     |         |#########|         |
    ///     |    d    |## e R ##|    f    |
    ///     |         |#########|         |
    ///     *---------*---------*---------*
    ///     |         |#########|         |
    ///     |    g    |### h ###|    i    |
    ///     |         |#########|         |
    ///     *---------*---------*---------*
    /// (180° rotation of `identity` clockwise)
    ///
    /// _,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,_
    ///
    /// ## Identity 3π½ Clockwise
    ///     *---------*---------*---------*
    ///     |         |         |#########|
    ///     |    a    |    b    |### c ###|
    ///     |         |         |#########|
    ///     *---------*---------*---------*
    ///     |#########|#########|#########|
    ///     |### d ###|## e R ##|### f ###|
    ///     |#########|#########|#########|
    ///     *---------*---------*---------*
    ///     |         |         |         |
    ///     |    g    |    h    |    i    |
    ///     |         |         |         |
    ///     *---------*---------*---------*
    /// (270° rotation of `identity` clockwise)
    ///
    /// - Tag: Block.l
    case lBlock
    
    // MARK: Block J
    
    /// `J` block with [blue fill](x-source-tag://Fill.blue) squares.
    ///
    /// # Rotations
    /// Below, let `R` marks the rotation center, and squares containing `#`
    /// are the filled ones.
    ///
    ///
    /// ## Identity
    ///     *---------*---------*---------*
    ///     |         |#########|         |
    ///     |    a    |### b ###|    c    |
    ///     |         |#########|         |
    ///     *---------*---------*---------*
    ///     |         |#########|         |
    ///     |    d    |## e R ##|    f    |
    ///     |         |#########|         |
    ///     *---------*---------*---------*
    ///     |#########|#########|         |
    ///     |### g ###|### h ###|    i    |
    ///     |#########|#########|         |
    ///     *---------*---------*---------*
    /// A.k.a. no rotation at all.
    ///
    /// _,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,_
    ///
    /// ## Identity π½ Clockwise
    ///     *---------*---------*---------*
    ///     |#########|         |         |
    ///     |### a ###|    b    |    c    |
    ///     |#########|         |         |
    ///     *---------*---------*---------*
    ///     |#########|#########|#########|
    ///     |### d ###|## e R ##|### f ###|
    ///     |#########|#########|#########|
    ///     *---------*---------*---------*
    ///     |         |         |         |
    ///     |    g    |    h    |    i    |
    ///     |         |         |         |
    ///     *---------*---------*---------*
    /// (90° rotation of `identity` clockwise)
    ///
    /// _,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,_
    ///
    /// ## Identity π Clockwise
    ///     *---------*---------*---------*
    ///     |         |#########|#########|
    ///     |    a    |### b ###|### c ###|
    ///     |         |#########|#########|
    ///     *---------*---------*---------*
    ///     |         |#########|         |
    ///     |    d    |## e R ##|    f    |
    ///     |         |#########|         |
    ///     *---------*---------*---------*
    ///     |         |#########|         |
    ///     |    g    |### h ###|    i    |
    ///     |         |#########|         |
    ///     *---------*---------*---------*
    /// (180° rotation of `identity` clockwise)
    ///
    /// _,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,_
    ///
    /// ## Identity 3π½ Clockwise
    ///     *---------*---------*---------*
    ///     |         |         |         |
    ///     |    a    |    b    |    c    |
    ///     |         |         |         |
    ///     *---------*---------*---------*
    ///     |#########|#########|#########|
    ///     |### d ###|## e R ##|### f ###|
    ///     |#########|#########|#########|
    ///     *---------*---------*---------*
    ///     |         |         |#########|
    ///     |    g    |    h    |### i ###|
    ///     |         |         |#########|
    ///     *---------*---------*---------*
    /// (270° rotation of `identity` clockwise)
    ///
    /// - Tag: Block.j
    case jBlock
    
    // MARK: Block T
    
    /// `T` block with [purple fill](x-source-tag://Fill.purple) squares.
    ///
    /// # Rotations
    /// Below, let `R` marks the rotation center, and squares containing `#`
    /// are the filled ones.
    ///
    ///
    /// ## Identity
    ///     *---------*---------*---------*
    ///     |         |         |         |
    ///     |    a    |    b    |    c    |
    ///     |         |         |         |
    ///     *---------*---------*---------*
    ///     |#########|#########|#########|
    ///     |### d ###|## e R ##|### f ###|
    ///     |#########|#########|#########|
    ///     *---------*---------*---------*
    ///     |         |#########|         |
    ///     |    g    |### h ###|    i    |
    ///     |         |#########|         |
    ///     *---------*---------*---------*
    /// A.k.a. no rotation at all.
    ///
    /// _,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,_
    ///
    /// ## Identity π½ Clockwise
    ///     *---------*---------*---------*
    ///     |         |#########|         |
    ///     |    a    |### b ###|    c    |
    ///     |         |#########|         |
    ///     *---------*---------*---------*
    ///     |#########|#########|         |
    ///     |### d ###|## e R ##|    f    |
    ///     |#########|#########|         |
    ///     *---------*---------*---------*
    ///     |         |#########|         |
    ///     |    g    |### h ###|    i    |
    ///     |         |#########|         |
    ///     *---------*---------*---------*
    /// (90° rotation of `identity` clockwise)
    ///
    /// _,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,_
    ///
    /// ## Identity π Clockwise
    ///     *---------*---------*---------*
    ///     |         |#########|         |
    ///     |    a    |### b ###|    c    |
    ///     |         |#########|         |
    ///     *---------*---------*---------*
    ///     |#########|#########|#########|
    ///     |### d ###|## e R ##|### f ###|
    ///     |#########|#########|#########|
    ///     *---------*---------*---------*
    ///     |         |         |         |
    ///     |    g    |    h    |    i    |
    ///     |         |         |         |
    ///     *---------*---------*---------*
    /// (180° rotation of `identity` clockwise)
    ///
    /// _,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,_
    ///
    /// ## Identity 3π½ Clockwise
    ///     *---------*---------*---------*
    ///     |         |#########|         |
    ///     |    a    |### b ###|    c    |
    ///     |         |#########|         |
    ///     *---------*---------*---------*
    ///     |         |#########|#########|
    ///     |    d    |## e R ##|### f ###|
    ///     |         |#########|#########|
    ///     *---------*---------*---------*
    ///     |         |#########|         |
    ///     |    g    |### h ###|    i    |
    ///     |         |#########|         |
    ///     *---------*---------*---------*
    /// (270° rotation of `identity` clockwise)
    ///
    /// - Tag: Block.t
    case tBlock
}
