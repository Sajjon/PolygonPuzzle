//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2020-07-04.
//

import Foundation

public extension Tile.Fill {
    var fillColor: FillColor {
        switch self {
        case .oBlockFill: return .yellow
        case .iBlockFill: return .teal
        case .zBlockFill: return .red
        case .sBlockFill: return .green
        case .lBlockFill: return .orange
        case .jBlockFill: return .blue
        case .tBlockFill: return .purple
        }
    }
}

public extension Tile.Fill {
    
    init(ofColor fillColor: FillColor) {
        switch fillColor {
        case .yellow: self = .oBlockFill
        case .teal: self = .iBlockFill
        case .red: self = .zBlockFill
        case .green: self = .sBlockFill
        case .orange: self = .lBlockFill
        case .blue: self = .jBlockFill
        case .purple: self = .tBlockFill
        }
    }
    
    /// The color of the fill of [Block](x-source-tag://Board.Block)s each block has a different one.
    ///
    /// The `rawValue` represents the color (on hex format) for the filll.
    enum FillColor: Int, Hashable, CaseIterable, CustomStringConvertible {
        
        /// The fill of the [`O` block](x-source-tag://Block.o)
        ///
        /// - Tag: FillColor.yellow
        case yellow = 0xFECB00
        
        /// The fill of the [`I` block](x-source-tag://Block.i)
        ///
        /// - Tag: FillColor.teal
        case teal = 0x009FDA
        
        /// The fill of the [`Z` block](x-source-tag://Block.z)
        ///
        /// - Tag: FillColor.red
        case red = 0xED2939
        
        /// The fill of the [`S` block](x-source-tag://Block.s)
        ///
        /// - Tag: FillColor.green
        case green = 0x69BE28
        
        /// The fill of the [`L` block](x-source-tag://Block.l)
        ///
        /// - Tag: FillColor.orange
        case orange = 0xFF7900
        
        /// The fill of the [`J` block](x-source-tag://Block.j)
        ///
        /// - Tag: FillColor.blue
        case blue = 0x0065BD
        
        /// The fill of the [`T` block](x-source-tag://Block.t)
        ///
        /// - Tag: FillColor.purple
        case purple = 0x952D98

    }
}

public extension Tile.Fill.FillColor {
    
    var description: String {
        switch self {
        case .yellow: return "💛"
        case .teal: return "🤎" // 🩱
        case .red: return "❤️"
        case .green: return "💚"
        case .orange: return "🧡"
        case .blue: return "💙"
        case .purple: return "💜"
        }
    }
    
}
