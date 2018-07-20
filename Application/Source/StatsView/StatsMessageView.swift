import UIKit

class StatsMessageView:UIView {
    weak var label:UILabel!
    
    init() {
        super.init(frame:CGRect.zero)
        self.configureView()
        self.makeOutlets()
        self.layoutOutlets()
    }
    
    required init?(coder:NSCoder) { return nil }
    
    private func configureView() {
        self.isUserInteractionEnabled = false
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func makeOutlets() {
        let label:UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.isUserInteractionEnabled = false
        label.textColor = UIColor(white:0.5, alpha:1)
        label.font = UIFont.systemFont(ofSize:Constants.fontSize, weight:UIFont.Weight.light)
        label.numberOfLines = 0
        self.label = label
        self.addSubview(label)
    }
    
    private func layoutOutlets() {
        self.label.leftAnchor.constraint(equalTo:self.leftAnchor, constant:Constants.margin).isActive = true
        self.label.rightAnchor.constraint(equalTo:self.rightAnchor, constant:-Constants.margin).isActive = true
        self.label.heightAnchor.constraint(greaterThanOrEqualToConstant:0).isActive = true
        if #available(iOS 11.0, *) {
            self.label.topAnchor.constraint(equalTo:self.safeAreaLayoutGuide.topAnchor,
                                            constant:Constants.margin).isActive = true
        } else {
            self.label.topAnchor.constraint(equalTo:self.topAnchor, constant:Constants.margin).isActive = true
        }
    }
}

private struct Constants {
    static let fontSize:CGFloat = 16
    static let margin:CGFloat = 20
}
