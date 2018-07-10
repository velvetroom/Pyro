import UIKit

struct UsersConstants {
    struct Collection {
        static let identifier:String = String(ObjectIdentifier(UsersViewContentCell.self).hashValue)
        static let cellHeight:CGFloat = 60
        static let cellSeparation:CGFloat = 2
    }
    
    struct Cell {
        static let titleFontSize:CGFloat = 16
        static let subtitleFontSize:CGFloat = 13
        static let margin:CGFloat = 20
    }
}
