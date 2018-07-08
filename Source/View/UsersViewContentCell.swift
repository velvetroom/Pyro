import UIKit

class UsersViewContentCell:UICollectionViewCell {
    override init(frame:CGRect) {
        super.init(frame:CGRect.zero)
        self.configureView()
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
            self.backgroundColor = UIColor(white:0.85, alpha:1)
        } else {
            self.backgroundColor = UIColor.white
        }
    }
    
    private func makeOutlets() {
        
    }
    
    private func layoutOutlets() {
        
    }
}
