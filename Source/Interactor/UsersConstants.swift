import UIKit

struct UsersConstants {
    struct Collection {
        static let identifier:String = String(ObjectIdentifier(UsersViewContentCell.self).hashValue)
        static let cellHeight:CGFloat = 40
        static let cellSeparation:CGFloat = 1
    }
    
    struct Cell {
        static let titleFontSize:CGFloat = 18
        static let subtitleFontSize:CGFloat = 16
    }
}
