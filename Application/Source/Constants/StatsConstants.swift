import UIKit

struct StatsConstants {
    struct Collection {
        static let identifier:String = String(ObjectIdentifier(StatsViewContentCell.self).hashValue)
        static let cellHeight:CGFloat = 100
        static let cellSeparation:CGFloat = 2
    }
    
    struct Cell {
        static let titleFontSize:CGFloat = 16
        static let subtitleFontSize:CGFloat = 13
        static let margin:CGFloat = 20
    }
}
