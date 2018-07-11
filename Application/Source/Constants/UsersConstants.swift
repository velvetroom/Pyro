import UIKit

struct UsersConstants {
    struct New {
        static let fontSize:CGFloat = 20
        static let insets:CGFloat = 5
    }
    
    struct Collection {
        static let identifier:String = String(ObjectIdentifier(UsersViewContentCell.self).hashValue)
        static let cellHeight:CGFloat = 64
        static let cellSeparation:CGFloat = 2
    }
    
    struct Cell {
        static let titleFontSize:CGFloat = 16
        static let subtitleFontSize:CGFloat = 13
        static let margin:CGFloat = 18
    }
}
