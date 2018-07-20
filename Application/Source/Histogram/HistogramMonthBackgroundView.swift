import UIKit

class HistogramMonthBackgroundView:UIView {
    init() {
        super.init(frame:CGRect.zero)
        self.configureView()
        self.drawGradient()
    }
    
    required init?(coder:NSCoder) { return nil }
    override open class var layerClass:AnyClass { get { return CAGradientLayer.self } }
    
    private func configureView() {
        self.clipsToBounds = true
        self.backgroundColor = UIColor.clear
        self.translatesAutoresizingMaskIntoConstraints = false
        self.isUserInteractionEnabled = false
    }
    
    private func drawGradient() {
        let gradientLayer:CAGradientLayer = self.layer as! CAGradientLayer
        gradientLayer.startPoint = CGPoint(x:0.5, y:0)
        gradientLayer.endPoint = CGPoint(x:0.5, y:1)
        gradientLayer.locations = [0, 1]
        gradientLayer.colors = [UIColor(white:1, alpha:0).cgColor,
                                UIColor(red:0.4, green:0.7, blue:0.9, alpha:0.5).cgColor]
    }
}
