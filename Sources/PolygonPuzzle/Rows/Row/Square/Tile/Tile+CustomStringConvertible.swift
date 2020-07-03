//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2020-07-03.
//

import Foundation

extension Tile: CustomStringConvertible {
    public var description: String {
        switch self {
        case .empty: return "🤍"
        case .filled(let fill):
            switch fill {
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
}
