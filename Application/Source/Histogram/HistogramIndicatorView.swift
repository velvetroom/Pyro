import UIKit

class HistogramIndicatorView:UIView {
    weak var layoutY:NSLayoutConstraint!
    private var indicatorSize:CGSize
    
    init() {
        self.indicatorSize = CGSize(width:Constants.small, height:Constants.small)
        super.init(frame:CGRect.zero)
        self.configureView()
    }
    
    required init?(coder:NSCoder) { return nil }
    override var intrinsicContentSize:CGSize { get { return self.indicatorSize } }
    
    func highlight() {
        self.indicatorSize = CGSize(width:Constants.big, height:Constants.big)
        self.alpha = Constants.alphaOn
        self.layer.cornerRadius = Constants.big / 2.0
        self.invalidateIntrinsicContentSize()
    }
    
    func unhighlight() {
        self.indicatorSize = CGSize(width:Constants.small, height:Constants.small)
        self.alpha = Constants.alphaOff
        self.layer.cornerRadius = 0
        self.invalidateIntrinsicContentSize()
    }
    
    private func configureView() {
        self.backgroundColor = UIColor.black
        self.translatesAutoresizingMaskIntoConstraints = false
        self.isUserInteractionEnabled = false
        self.clipsToBounds = true
        self.alpha = Constants.alphaOff
    }
}

private struct Constants {
    static let small:CGFloat = 2
    static let big:CGFloat = 12
    static let alphaOn:CGFloat = 1
    static let alphaOff:CGFloat = 0.4
}
