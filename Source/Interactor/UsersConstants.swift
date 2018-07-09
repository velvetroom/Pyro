import UIKit

struct UsersConstants {
    struct Collection {
        static let identifier:String = String(ObjectIdentifier(UsersViewContentCell.self).hashValue)
        static let cellHeight:CGFloat = 60
        static let cellSeparation:CGFloat = 2
    }
    
    struct Cell {
        static let titleFontSize:CGFloat = 18
        static let subtitleFontSize:CGFloat = 15
        static let margin:CGFloat = 20
    }
}