//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2020-07-03.
//

import Foundation

public enum BlockRotation: Hashable, CaseIterable {
    case identity
    case idπ½Clockwise
    case idπClockwise
    case id3π½Clockwise
}

private extension CaseIterable where Self: Equatable, AllCases == [Self] {
    func adjacent(_ adjecentIndex: (Array<Self>.Index) -> Array<Self>.Index) -> Self {
        guard let indexOfSelf = Self.allCases.firstIndex(where: { $0 == self }) else {
            incorrectImplementation(shouldAlwaysBeAbleTo: "Get index of self")
        }
        let indexOfNext = adjecentIndex(indexOfSelf)
        return Self.allCases[indexOfNext]
    }
    
    func elementAfterWrappingAround() -> Self {
        adjacent { index in
            let next = Self.allCases.index(after: index)
            return next == Self.allCases.endIndex ? Self.allCases.startIndex : next
        }
    }
    
    func elementBeforeWrappingAround() -> Self {
        adjacent { index in
            index == Self.allCases.startIndex ? (Self.allCases.endIndex - 1) : Self.allCases.index(before: index)
        }
    }
}

public extension BlockRotation {
    func clockwiseRotation() -> Self {
        self.elementAfterWrappingAround()
    }
    
    func counterClockwiseRotation() -> Self {
        self.elementBeforeWrappingAround()
    }
}
