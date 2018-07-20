import UIKit

class StatsSynchView:UIView {
    weak var label:UILabel!
    
    init() {
        super.init(frame:CGRect.zero)
        self.configureView()
        self.makeOutlets()
        self.layoutOutlets()
    }
    
    required init?(coder:NSCoder) { return nil }
    override var intrinsicContentSize:CGSize { get { return CGSize(width:Constants.width, height:Constants.height) } }
    
    private func configureView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.isUserInteractionEnabled = false
    }
    
    private func makeOutlets() {
        let label:UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.isUserInteractionEnabled = false
        label.font = UIFont.systemFont(ofSize:Constants.fontSize, weight:UIFont.Weight.light)
        label.numberOfLines = 0
        label.textColor = UIColor(white:0, alpha:0.45)
        self.label = label
        self.addSubview(label)
    }
    
    private func layoutOutlets() {
        self.label.leftAnchor.constraint(equalTo:self.leftAnchor, constant:Constants.left).isActive = true
        self.label.centerYAnchor.constraint(equalTo:self.centerYAnchor).isActive = true
        self.label.widthAnchor.constraint(greaterThanOrEqualToConstant:0).isActive = true
        self.label.heightAnchor.constraint(greaterThanOrEqualToConstant:0).isActive = true
    }
}

private struct Constants {
    static let left:CGFloat = 5
    static let width:CGFloat = 300
    static let height:CGFloat = 34
    static let fontSize:CGFloat = 12
}
