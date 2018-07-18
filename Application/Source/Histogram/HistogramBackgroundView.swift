import UIKit

class HistograBackgroundView:UIView {
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
        gradientLayer.colors = [UIColor.white.cgColor, UIColor(white:0.95, alpha:1).cgColor]
    }
}
