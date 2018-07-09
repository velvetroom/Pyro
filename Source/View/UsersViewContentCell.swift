import UIKit

class UsersViewContentCell:UICollectionViewCell {
    weak var label:UILabel!
    
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
            self.label.textColor = UIColor.white
            self.backgroundColor = self.tintColor
        } else {
            self.label.textColor = UIColor.black
            self.backgroundColor = UIColor.white
        }
    }
    
    private func makeOutlets() {
        let label:UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 0
        self.label = label
        self.contentView.addSubview(label)
    }
    
    private func layoutOutlets() {
        self.label.topAnchor.constraint(equalTo:self.topAnchor).isActive = true
        self.label.bottomAnchor.constraint(equalTo:self.bottomAnchor).isActive = true
        self.label.leftAnchor.constraint(equalTo:self.leftAnchor, constant:UsersConstants.Cell.margin).isActive = true
        self.label.rightAnchor.constraint(equalTo:self.rightAnchor, constant:UsersConstants.Cell.margin).isActive = true
    }
}
