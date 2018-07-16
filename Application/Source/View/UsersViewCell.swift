import UIKit

class UsersViewCell:UICollectionViewCell {
    weak var labelName:UILabel!
    weak var labelValue:UILabel!
    
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
            self.backgroundColor = UIColor.clear
        } else {
            self.backgroundColor = UIColor.white
        }
    }
    
    private func makeOutlets() {
        self.makeName()
        self.makeValue()
    }
    
    private func layoutOutlets() {
        self.layoutName()
        self.layoutValue()
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
}

private struct Constants {
    static let margin:CGFloat = 18
}
