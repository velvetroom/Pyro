import UIKit

class UsersCell:UICollectionViewCell {
    weak var labelName:UILabel!
    weak var labelValue:UILabel!
    weak var border:UIView!
    weak var indicator:UIView!
    
    override init(frame:CGRect) {
        super.init(frame:CGRect.zero)
        self.makeOutlets()
        self.layoutOutlets()
        self.configureView()
    }
    
    required init?(coder:NSCoder) {
        return nil
    }
    
    override var isSelected:Bool {
        didSet {
            self.configureView()
        }
    }
    
    override var isHighlighted:Bool {
        didSet {
            self.configureView()
        }
    }
    
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
        self.labelName = label
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
        self.labelValue = label
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
        self.labelName.topAnchor.constraint(equalTo:self.topAnchor).isActive = true
        self.labelName.bottomAnchor.constraint(equalTo:self.bottomAnchor).isActive = true
        self.labelName.leftAnchor.constraint(equalTo:self.leftAnchor, constant:Constants.margin).isActive = true
        self.labelName.rightAnchor.constraint(equalTo:self.rightAnchor, constant:-Constants.margin).isActive = true
    }
    
    private func layoutValue() {
        self.labelValue.topAnchor.constraint(equalTo:self.topAnchor).isActive = true
        self.labelValue.bottomAnchor.constraint(equalTo:self.bottomAnchor).isActive = true
        self.labelValue.leftAnchor.constraint(equalTo:self.leftAnchor, constant:Constants.margin).isActive = true
        self.labelValue.rightAnchor.constraint(equalTo:self.rightAnchor, constant:-Constants.margin).isActive = true
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
