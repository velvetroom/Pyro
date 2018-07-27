import UIKit

class StatsHistogramMonthView:UIView {
    weak var indicator:UIView!
    weak var borderLeft:UIView!
    weak var borderRight:UIView!
    weak var indicatorY:NSLayoutConstraint!
    weak var indicatorWidth:NSLayoutConstraint!
    weak var indicatorHeight:NSLayoutConstraint!
    var contributions:NSAttributedString
    
    init() {
        self.contributions = NSAttributedString()
        super.init(frame:CGRect.zero)
        self.isUserInteractionEnabled = false
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.clear
        self.alpha = Constants.alphaUnhighlight
        self.makeOutlets()
        self.layoutOutlets()
    }
    
    required init?(coder:NSCoder) { return nil }
    override open class var layerClass:AnyClass { get { return CAGradientLayer.self } }
    
    func update(amount:CGFloat) {
        self.indicatorY.constant = amount
        UIView.animate(withDuration:Constants.animationDuration) { [weak self] in self?.layoutIfNeeded() }
    }
    
    func highlight() {
        self.indicatorWidth.constant = Constants.highlightSize
        self.indicatorHeight.constant = Constants.highlightSize
        UIView.animate(withDuration:Constants.animationDuration) { [weak self] in
            self?.alpha = Constants.alphaHighlight
            self?.layoutIfNeeded()
        }
    }
    
    func unhighlight() {
        self.indicatorWidth.constant = Constants.unhighlightSize
        self.indicatorHeight.constant = Constants.unhighlightSize
        UIView.animate(withDuration:Constants.animationDuration) { [weak self] in
            self?.alpha = Constants.alphaUnhighlight
            self?.layoutIfNeeded()
        }
    }
    
    private func makeOutlets() {
        let gradientLayer:CAGradientLayer = self.layer as! CAGradientLayer
        gradientLayer.startPoint = CGPoint(x:0.5, y:0.3)
        gradientLayer.endPoint = CGPoint(x:0.5, y:1)
        gradientLayer.locations = [0, 1]
        gradientLayer.colors = [UIColor(white:1, alpha:0).cgColor, UIColor.sharedBlue.withAlphaComponent(0.2).cgColor]
        
        let borderLeft:UIView = UIView()
        borderLeft.isUserInteractionEnabled = false
        borderLeft.translatesAutoresizingMaskIntoConstraints = false
        borderLeft.backgroundColor = UIColor.white
        self.borderLeft = borderLeft
        self.addSubview(borderLeft)
        
        let borderRight:UIView = UIView()
        borderRight.isUserInteractionEnabled = false
        borderRight.translatesAutoresizingMaskIntoConstraints = false
        borderRight.backgroundColor = UIColor.white
        self.borderRight = borderRight
        self.addSubview(borderRight)
        
        let indicator:UIView = UIView()
        indicator.isUserInteractionEnabled = false
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.backgroundColor = UIColor.sharedBlue
        self.indicator = indicator
        self.addSubview(indicator)
    }
    
    private func layoutOutlets() {
        self.borderLeft.topAnchor.constraint(equalTo:self.topAnchor).isActive = true
        self.borderLeft.bottomAnchor.constraint(equalTo:self.bottomAnchor).isActive = true
        self.borderLeft.leftAnchor.constraint(equalTo:self.leftAnchor).isActive = true
        self.borderLeft.widthAnchor.constraint(equalToConstant:Constants.border).isActive = true
        
        self.borderRight.topAnchor.constraint(equalTo:self.topAnchor).isActive = true
        self.borderRight.bottomAnchor.constraint(equalTo:self.bottomAnchor).isActive = true
        self.borderRight.rightAnchor.constraint(equalTo:self.rightAnchor).isActive = true
        self.borderRight.widthAnchor.constraint(equalToConstant:Constants.border).isActive = true
        
        self.indicator.centerXAnchor.constraint(equalTo:self.centerXAnchor).isActive = true
        self.indicatorWidth = self.indicator.widthAnchor.constraint(equalToConstant:Constants.unhighlightSize)
        self.indicatorHeight = self.indicator.heightAnchor.constraint(equalToConstant:Constants.unhighlightSize)
        self.indicatorY = self.indicator.centerYAnchor.constraint(equalTo:self.bottomAnchor)
        self.indicatorY.isActive = true
        self.indicatorWidth.isActive = true
        self.indicatorHeight.isActive = true
    }
}

private struct Constants {
    static let animationDuration:TimeInterval = 0.3
    static let border:CGFloat = 0.5
    static let unhighlightSize:CGFloat = 6
    static let highlightSize:CGFloat = 12
    static let alphaHighlight:CGFloat = 1
    static let alphaUnhighlight:CGFloat = 0.5
}
