import UIKit

struct StatsConstants {
    struct Collection {
        static let identifier:String = String(ObjectIdentifier(StatsViewContentCell.self).hashValue)
        static let cellHeight:CGFloat = 70
        static let cellSeparation:CGFloat = 2
    }
    
    struct Cell {
        static let nameFontSize:CGFloat = 14
        static let valueFontSize:CGFloat = 14
        static let marginHorizontal:CGFloat = 18
        static let marginVertical:CGFloat = 12
    }
}
