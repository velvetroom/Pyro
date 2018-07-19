import UIKit

class HistogramIndicatorView:UIView {
    weak var layoutY:NSLayoutConstraint!
    private var indicatorSize:CGSize
    private let sizeHighlight:CGSize
    private let sizeUnhighlight:CGSize
    
    init() {
        self.sizeHighlight = CGSize(width:Constants.highlightSize, height:Constants.highlightSize)
        self.sizeUnhighlight = CGSize(width:Constants.unhighlightSize, height:Constants.unhighlightSize)
        self.indicatorSize = self.sizeUnhighlight
        super.init(frame:CGRect.zero)
        self.configureView()
    }
    
    required init?(coder:NSCoder) { return nil }
    override var intrinsicContentSize:CGSize { get { return self.indicatorSize } }
    
    func highlight() {
        self.indicatorSize = self.sizeHighlight
        self.alpha = Constants.alphaOn
        self.invalidateIntrinsicContentSize()
    }
    
    func unhighlight() {
        self.indicatorSize = self.sizeUnhighlight
        self.alpha = Constants.alphaOff
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
    static let unhighlightSize:CGFloat = 12
    static let highlightSize:CGFloat = 6
    static let alphaOn:CGFloat = 1
    static let alphaOff:CGFloat = 0.04
}
