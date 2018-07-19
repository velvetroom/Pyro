import UIKit

class StatsDetailView:UIView {
    weak var label:UILabel!
    
    init() {
        super.init(frame:CGRect.zero)
        self.configureView()
        self.makeOutlets()
        self.layoutOutlets()
    }
    
    required init?(coder:NSCoder) { return nil }
    override var intrinsicContentSize:CGSize { get { return CGSize(width:UIView.noIntrinsicMetric,
                                                                   height:Constants.height) } }
    
    private func configureView() {
        self.isUserInteractionEnabled = false
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func makeOutlets() {
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.backgroundColor = UIColor.clear
        self.label = label
        self.addSubview(label)
    }
    
    private func layoutOutlets() {
        self.label.topAnchor.constraint(equalTo:self.topAnchor).isActive = true
        self.label.leftAnchor.constraint(equalTo:self.leftAnchor, constant:Constants.margin).isActive = true
        self.label.widthAnchor.constraint(greaterThanOrEqualToConstant:0).isActive = true
        self.label.heightAnchor.constraint(greaterThanOrEqualToConstant:0).isActive = true
    }
}

private struct Constants {
    static let height:CGFloat = 80
    static let margin:CGFloat = 10
}
