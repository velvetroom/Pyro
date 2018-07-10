import UIKit

class StatsViewContentCell:UICollectionViewCell {
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
    
    private func configureView() {
        self.backgroundColor = UIColor.white
        self.isUserInteractionEnabled = false
    }
    
    private func makeOutlets() {
        let label:UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 0
        label.textColor = UIColor.black
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
