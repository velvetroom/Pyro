import UIKit

class HistogramMonthView:UIView {
    weak var borderLeft:UIView!
    weak var borderRight:UIView!
    
    init() {
        super.init(frame:CGRect.zero)
        self.configureView()
        self.makeOutlets()
        self.layoutOutlets()
    }
    
    required init?(coder:NSCoder) {
        return nil
    }
    
    private func configureView() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func makeOutlets() {
        self.makeBorderLeft()
        self.makeBorderRight()
    }
    
    private func layoutOutlets() {
        self.layoutBorderLeft()
        self.layoutBorderRight()
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
    static let border:CGFloat = 0.5
}
