import UIKit

class HistogramMonthView:UIView {
    weak var indicator:HistogramIndicatorView!
    weak var borderLeft:UIView!
    weak var borderRight:UIView!
    weak var background:HistogramMonthBackgroundView!
    var contributions:NSAttributedString
    
    init() {
        self.contributions = NSAttributedString()
        super.init(frame:CGRect.zero)
        self.isUserInteractionEnabled = false
        self.translatesAutoresizingMaskIntoConstraints = false
        self.makeOutlets()
        self.layoutOutlets()
    }
    
    required init?(coder:NSCoder) { return nil }
    
    func update(amount:CGFloat) {
        self.indicator.layoutY.constant = amount
        UIView.animate(withDuration:Constants.animationDuration) { [weak self] in
            self?.layoutIfNeeded()
        }
    }
    
    func highlight() {
        UIView.animate(withDuration:Constants.animationDuration) { [weak self] in
            self?.indicator.highlight()
            self?.background.alpha = 1
            self?.layoutIfNeeded()
        }
    }
    
    func unhighlight() {
        UIView.animate(withDuration:Constants.animationDuration) { [weak self] in
            self?.indicator.unhighlight()
            self?.background.alpha = 0
            self?.layoutIfNeeded()
        }
    }
    
    private func makeOutlets() {
        self.makeBackground()
        self.makeBorderLeft()
        self.makeBorderRight()
        self.makeIndicator()
    }
    
    private func layoutOutlets() {
        self.layoutBackground()
        self.layoutBorderLeft()
        self.layoutBorderRight()
        self.layoutIndicator()
    }
    
    private func makeIndicator() {
        let indicator:HistogramIndicatorView = HistogramIndicatorView()
        self.indicator = indicator
        self.addSubview(indicator)
    }
    
    private func makeBorderLeft() {
        let borderLeft:UIView = UIView()
        borderLeft.isUserInteractionEnabled = false
        borderLeft.translatesAutoresizingMaskIntoConstraints = false
        borderLeft.backgroundColor = UIColor.white
        self.borderLeft = borderLeft
        self.addSubview(borderLeft)
    }
    
    private func makeBorderRight() {
        let borderRight:UIView = UIView()
        borderRight.isUserInteractionEnabled = false
        borderRight.translatesAutoresizingMaskIntoConstraints = false
        borderRight.backgroundColor = UIColor.white
        self.borderRight = borderRight
        self.addSubview(borderRight)
    }
    
    private func makeBackground() {
        let background:HistogramMonthBackgroundView = HistogramMonthBackgroundView()
        background.alpha = 0
        self.background = background
        self.addSubview(background)
    }
    
    private func layoutIndicator() {
        self.indicator.centerXAnchor.constraint(equalTo:self.centerXAnchor).isActive = true
        self.indicator.layoutY = self.indicator.centerYAnchor.constraint(equalTo:self.bottomAnchor)
        self.indicator.layoutY.isActive = true
    }
    
    private func layoutBorderLeft() {
        self.borderLeft.topAnchor.constraint(equalTo:self.topAnchor).isActive = true
        self.borderLeft.bottomAnchor.constraint(equalTo:self.bottomAnchor).isActive = true
        self.borderLeft.leftAnchor.constraint(equalTo:self.leftAnchor).isActive = true
        self.borderLeft.widthAnchor.constraint(equalToConstant:Constants.border).isActive = true
    }
    
    private func layoutBorderRight() {
        self.borderRight.topAnchor.constraint(equalTo:self.topAnchor).isActive = true
        self.borderRight.bottomAnchor.constraint(equalTo:self.bottomAnchor).isActive = true
        self.borderRight.rightAnchor.constraint(equalTo:self.rightAnchor).isActive = true
        self.borderRight.widthAnchor.constraint(equalToConstant:Constants.border).isActive = true
    }
    
    private func layoutBackground() {
        self.background.topAnchor.constraint(equalTo:self.topAnchor).isActive = true
        self.background.bottomAnchor.constraint(equalTo:self.bottomAnchor).isActive = true
        self.background.leftAnchor.constraint(equalTo:self.leftAnchor).isActive = true
        self.background.rightAnchor.constraint(equalTo:self.rightAnchor).isActive = true
    }
}

private struct Constants {
    static let animationDuration:TimeInterval = 0.3
    static let border:CGFloat = 0.5
}
