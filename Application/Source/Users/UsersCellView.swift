import UIKit

class UsersCellView:UICollectionViewCell {
    static let identifier:String = String(describing:self)
    weak var name:UILabel!
    weak var streak:UILabel!
    weak var border:UIView!
    weak var avatar:Avatar!
    
    override init(frame:CGRect) {
        super.init(frame:CGRect.zero)
        self.makeOutlets()
        self.layoutOutlets()
        self.configureView()
    }
    
    required init?(coder:NSCoder) { return nil }
    override var isSelected:Bool { didSet { self.configureView() } }
    override var isHighlighted:Bool { didSet { self.configureView() } }
    
    private func configureView() {
        if self.isSelected || self.isHighlighted {
            self.backgroundColor = self.border.backgroundColor
        } else {
            self.backgroundColor = UIColor.clear
        }
    }
    
    private func makeOutlets() {
        let name:UILabel = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.isUserInteractionEnabled = false
        name.numberOfLines = 0
        name.textColor = UIColor.black
        self.name = name
        self.contentView.addSubview(name)
        
        let streak:UILabel = UILabel()
        streak.translatesAutoresizingMaskIntoConstraints = false
        streak.isUserInteractionEnabled = false
        streak.numberOfLines = 0
        streak.textColor = UIColor.black
        streak.textAlignment = NSTextAlignment.right
        streak.font = UIFont.systemFont(ofSize:Constants.streakFont, weight:UIFont.Weight.light)
        self.streak = streak
        self.contentView.addSubview(streak)
        
        let border:UIView = UIView()
        border.translatesAutoresizingMaskIntoConstraints = false
        border.backgroundColor = UIColor(white:0.92, alpha:1)
        border.isUserInteractionEnabled = false
        self.border = border
        self.contentView.addSubview(border)
        
        let avatar:Avatar = Avatar()
        self.avatar = avatar
        self.addSubview(avatar)
    }
    
    private func layoutOutlets() {
        self.name.topAnchor.constraint(equalTo:self.topAnchor).isActive = true
        self.name.bottomAnchor.constraint(equalTo:self.bottomAnchor).isActive = true
        self.name.leftAnchor.constraint(equalTo:self.avatar.rightAnchor, constant:Constants.avatarRight).isActive = true
        self.name.rightAnchor.constraint(equalTo:self.rightAnchor, constant:-Constants.margin).isActive = true
        
        self.streak.topAnchor.constraint(equalTo:self.topAnchor).isActive = true
        self.streak.bottomAnchor.constraint(equalTo:self.bottomAnchor).isActive = true
        self.streak.leftAnchor.constraint(equalTo:self.leftAnchor, constant:Constants.margin).isActive = true
        self.streak.rightAnchor.constraint(equalTo:self.rightAnchor, constant:-Constants.margin).isActive = true
        
        self.border.leftAnchor.constraint(equalTo:self.leftAnchor).isActive = true
        self.border.rightAnchor.constraint(equalTo:self.rightAnchor).isActive = true
        self.border.bottomAnchor.constraint(equalTo:self.bottomAnchor).isActive = true
        self.border.heightAnchor.constraint(equalToConstant:Constants.border).isActive = true
        
        self.avatar.leftAnchor.constraint(equalTo:self.leftAnchor).isActive = true
        self.avatar.topAnchor.constraint(equalTo:self.topAnchor).isActive = true
        self.avatar.bottomAnchor.constraint(equalTo:self.bottomAnchor).isActive = true
        self.avatar.widthAnchor.constraint(equalTo:self.avatar.heightAnchor).isActive = true
    }
}

private struct Constants {
    static let margin:CGFloat = 18
    static let border:CGFloat = 1
    static let streakFont:CGFloat = 12
    static let avatarRight:CGFloat = 8
}
