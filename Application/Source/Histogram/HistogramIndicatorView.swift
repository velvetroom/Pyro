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
        self.backgroundColor = UIColor(red:0.4, green:0.7, blue:0.9, alpha:1)
        self.invalidateIntrinsicContentSize()
    }
    
    func unhighlight() {
        self.indicatorSize = self.sizeUnhighlight
        self.backgroundColor = UIColor(white:0, alpha:0.04)
        self.invalidateIntrinsicContentSize()
    }
    
    private func configureView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.isUserInteractionEnabled = false
        self.clipsToBounds = true
        self.unhighlight()
    }
}

private struct Constants {
    static let unhighlightSize:CGFloat = 12
    static let highlightSize:CGFloat = 6
}
