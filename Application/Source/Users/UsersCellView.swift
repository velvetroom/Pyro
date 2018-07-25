import UIKit

class UsersCellView:UICollectionViewCell {
    static let identifier:String = String(describing:self)
    weak var name:UILabel!
    weak var value:UILabel!
    weak var border:UIView!
    
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
        
        let value:UILabel = UILabel()
        value.translatesAutoresizingMaskIntoConstraints = false
        value.isUserInteractionEnabled = false
        value.numberOfLines = 0
        value.textColor = UIColor.black
        value.textAlignment = NSTextAlignment.right
        self.value = value
        self.contentView.addSubview(value)
        
        let border:UIView = UIView()
        border.translatesAutoresizingMaskIntoConstraints = false
        border.backgroundColor = UIColor(white:0.92, alpha:1)
        border.isUserInteractionEnabled = false
        self.border = border
        self.contentView.addSubview(border)
    }
    
    private func layoutOutlets() {
        self.name.topAnchor.constraint(equalTo:self.topAnchor).isActive = true
        self.name.bottomAnchor.constraint(equalTo:self.bottomAnchor).isActive = true
        self.name.leftAnchor.constraint(equalTo:self.leftAnchor, constant:Constants.margin).isActive = true
        self.name.rightAnchor.constraint(equalTo:self.rightAnchor, constant:-Constants.margin).isActive = true
        
        self.value.topAnchor.constraint(equalTo:self.topAnchor).isActive = true
        self.value.bottomAnchor.constraint(equalTo:self.bottomAnchor).isActive = true
        self.value.leftAnchor.constraint(equalTo:self.leftAnchor, constant:Constants.margin).isActive = true
        self.value.rightAnchor.constraint(equalTo:self.rightAnchor, constant:-Constants.margin).isActive = true
        
        self.border.leftAnchor.constraint(equalTo:self.leftAnchor).isActive = true
        self.border.rightAnchor.constraint(equalTo:self.rightAnchor).isActive = true
        self.border.bottomAnchor.constraint(equalTo:self.bottomAnchor).isActive = true
        self.border.heightAnchor.constraint(equalToConstant:Constants.border).isActive = true
    }
}

private struct Constants {
    static let margin:CGFloat = 18
    static let border:CGFloat = 1
}
