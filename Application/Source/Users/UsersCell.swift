import UIKit

class UsersCell:UICollectionViewCell {
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
        self.makeName()
        self.makeValue()
        self.makerBorder()
    }
    
    private func layoutOutlets() {
        self.layoutName()
        self.layoutValue()
        self.layoutBorder()
    }
    
    private func makeName() {
        let label:UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 0
        label.textColor = UIColor.black
        self.name = label
        self.contentView.addSubview(label)
    }
    
    private func makeValue() {
        let label:UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 0
        label.textColor = UIColor.black
        label.textAlignment = NSTextAlignment.right
        self.value = label
        self.contentView.addSubview(label)
    }
    
    private func makerBorder() {
        let border:UIView = UIView()
        border.translatesAutoresizingMaskIntoConstraints = false
        border.backgroundColor = UIColor(white:0.92, alpha:1)
        border.isUserInteractionEnabled = false
        self.border = border
        self.contentView.addSubview(border)
    }
    
    private func layoutName() {
        self.name.topAnchor.constraint(equalTo:self.topAnchor).isActive = true
        self.name.bottomAnchor.constraint(equalTo:self.bottomAnchor).isActive = true
        self.name.leftAnchor.constraint(equalTo:self.leftAnchor, constant:Constants.margin).isActive = true
        self.name.rightAnchor.constraint(equalTo:self.rightAnchor, constant:-Constants.margin).isActive = true
    }
    
    private func layoutValue() {
        self.value.topAnchor.constraint(equalTo:self.topAnchor).isActive = true
        self.value.bottomAnchor.constraint(equalTo:self.bottomAnchor).isActive = true
        self.value.leftAnchor.constraint(equalTo:self.leftAnchor, constant:Constants.margin).isActive = true
        self.value.rightAnchor.constraint(equalTo:self.rightAnchor, constant:-Constants.margin).isActive = true
    }
    
    private func layoutBorder() {
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
