//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2020-07-03.
//

import Foundation

public extension Rows {
    
    enum InlayPieceError: Swift.Error {
        case collision
    }
    
    static func reduce(
        state rows: Self,
        inlaying piece: FallingPiece
    ) -> Result<Self, InlayPieceError> {
        fatalError()
    }
}
