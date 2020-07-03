//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2020-07-03.
//

import Foundation

public extension FallingPiece {
    struct BoundingBox {
        public let size: Size
        
        /// Coordinate of the top left corner of this bounding box
        public internal(set) var coordinate: Coordinate
    }
}


public extension FallingPiece {
    
    var size: Size {
        abstractFrame.size
    }
    
    var width: Size.Value {
        size.width
    }
    
    var height: Size.Value {
        size.height
    }
    
//    var coordinateOfTopLeftCornerOfBoundingBox: Coordinate {
//        abstractFrame.coordinate
//    }
//
//    var coordinateOfBottomRightCornerOfBoundingBox: Coordinate {
//        .init(
//            x: leftMostFilledSquare.columnIndex + width-1,
//            y: topMostFilledSquare.rowIndex + height-1
//        )
//    }
}
