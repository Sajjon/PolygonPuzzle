
public struct Board: Hashable {
    private let rows: [Row]
    
    public init(width: Int = 10, height: Int = 20) {
        self.rows = (0..<height).map { .init(index: $0, width: width) }
    }
}

public extension Board {
    struct Row: Hashable {
        
        /// Index from top of the board
        let index: Int
        
        /// The width of the board, all rows in the board are expected to have the same width
        let width: Int
        
//        /// The tiles of this row, from left to right, equal number of elements as `width`, if the
//        /// tile is empty, the value will be [empty](x-source-tag://Tile.empty).
//        let tiles: [Tile]
        
        /// The squares/cells of this row, from left to right, equal number of elements as `width`
        let squares: [Square]
        
        internal init(index: Int, width: Int, squares: [Square]) {
            precondition(width >= 4) // size of `Block.iBlock`
            
            squares.forEach {
                assert($0.rowIndex == index)
            }
            assert(Set(squares.map { $0.columnIndex }).count == squares.count)
            self.index = index
            self.width = width
            self.squares = squares
        }
        
        public init(index: Int, width: Int) {
            self.init(
                index: index,
                width: width,
                squares: (0..<width).map { .init(columnIndex: $0, rowIndex: index) }
            )
        }
    }
}

public extension Board.Row {
    var isFilled: Bool {
        squares.allSatisfy({ $0.isFilled })
    }
}

// MARK: Square
public extension Board {
    
    struct Square: Hashable {
        
        /// The index of the row in which this square is found
        let rowIndex: Int
        
        /// Index from the left most column in the board
        let columnIndex: Int
        
        /// If the tile is empty the value will be [empty](x-source-tag://Tile.empty).
        private let tile: Tile
        
        init(columnIndex: Int, rowIndex: Int, tile: Tile = .empty) {
            self.rowIndex = rowIndex
            self.columnIndex = columnIndex
            self.tile = tile
        }
        
    }
}

public extension Board.Square {
    var isFilled: Bool {
        tile.isFilled
    }
}

// MARK: Tile
public extension Board {
    enum Tile: Hashable {
        
        /// Nothing occupies this tile.
        ///
        /// - Tag: Tile.empty
        case empty
        
        case filled(Fill)
    }
}

public extension Board.Tile {
    var isFilled: Bool {
        guard case .filled = self else {
            return false
        }
        return true
    }
    
    static let yellow:  Self = .filled(.yellow)
    static let teal:    Self = .filled(.teal)
    static let red:     Self = .filled(.red)
    static let green:   Self = .filled(.green)
    static let orange:  Self = .filled(.orange)
    static let blue:    Self = .filled(.blue)
    static let purple:  Self = .filled(.purple)
}

public extension Board.Tile {
    
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

public extension Board {
    /// The differently shaped and colored falling blocks that we need to fit into our already
    /// fallen blocks to form solid rows.
    ///
    /// - Tag: Board.Block
    enum Block {
        
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
}

