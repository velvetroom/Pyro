import UIKit

class HistogramMonthView:UIView {
    weak var layoutIndicatorBottom:NSLayoutConstraint!
    weak var indicator:UIView!
    weak var borderLeft:UIView!
    weak var borderRight:UIView!
    
    init() {
        super.init(frame:CGRect.zero)
        self.configureView()
        self.makeOutlets()
        self.layoutOutlets()
    }
    
    required init?(coder:NSCoder) { return nil }
    
    func update(amount:CGFloat) {
        self.layoutIndicatorBottom.constant = amount
        UIView.animate(withDuration:Constants.animationDuration) { [weak self] in
            self?.layoutIfNeeded()
        }
    }
    
    private func configureView() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func makeOutlets() {
        self.makeBorderLeft()
        self.makeBorderRight()
        self.makeIndicator()
    }
    
    private func layoutOutlets() {
        self.layoutBorderLeft()
        self.layoutBorderRight()
        self.layoutIndicator()
    }
    
    private func makeIndicator() {
        let indicator:UIView = UIView()
        indicator.backgroundColor = UIColor(white:0, alpha:0.2)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.isUserInteractionEnabled = false
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
    
    private func layoutIndicator() {
        self.indicator.centerXAnchor.constraint(equalTo:self.centerXAnchor).isActive = true
        self.indicator.heightAnchor.constraint(equalToConstant:Constants.indicator).isActive = true
        self.indicator.widthAnchor.constraint(equalToConstant:Constants.indicator).isActive = true
        self.layoutIndicatorBottom = self.indicator.bottomAnchor.constraint(equalTo:self.bottomAnchor)
        self.layoutIndicatorBottom.isActive = true
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
}

private struct Constants {
    static let animationDuration:TimeInterval = 0.3
    static let indicator:CGFloat = 2
    static let border:CGFloat = 0.5
}
