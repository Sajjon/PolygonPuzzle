//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2020-07-05.
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
