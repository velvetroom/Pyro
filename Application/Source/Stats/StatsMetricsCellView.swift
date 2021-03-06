import UIKit

class StatsMetricsCellView:UICollectionViewCell {
    static let identifier:String = String(describing:self)
    static let width:CGFloat = 45
    weak var label:UILabel!
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        self.backgroundColor = UIColor.clear
        self.makeOutlets()
        self.layoutOutlets()
        self.configureView()
    }
    
    required init?(coder:NSCoder) { return nil }
    override var isSelected:Bool { didSet { self.configureView() } }
    override var isHighlighted:Bool { didSet { self.configureView() } }
    
    private func configureView() {
        if self.isSelected || self.isHighlighted {
            self.label.alpha = Constants.alphaOn
        } else {
            self.label.alpha = Constants.alphaOff
        }
    }
    
    private func makeOutlets() {
        let label:UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = NSTextAlignment.center
        label.isUserInteractionEnabled = false
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize:Constants.fontSize, weight:UIFont.Weight.bold)
        self.label = label
        self.addSubview(label)
    }
    
    private func layoutOutlets() {
        self.label.topAnchor.constraint(equalTo:self.topAnchor).isActive = true
        self.label.bottomAnchor.constraint(equalTo:self.bottomAnchor).isActive = true
        self.label.leftAnchor.constraint(equalTo:self.leftAnchor).isActive = true
        self.label.rightAnchor.constraint(equalTo:self.rightAnchor).isActive = true
    }
}

private struct Constants {
    static let fontSize:CGFloat = 12
    static let alphaOn:CGFloat = 1
    static let alphaOff:CGFloat = 0.1
}
