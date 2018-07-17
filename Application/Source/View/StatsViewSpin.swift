import UIKit

class StatsViewSpin:UIView {
    weak var track:CAShapeLayer!
    weak var indicator:CAShapeLayer!
    
    init() {
        super.init(frame:CGRect.zero)
        self.configureView()
        self.configureTrack()
        self.configureIndicator()
        self.animateIndicator()
    }
    
    required init?(coder:NSCoder) {
        return nil
    }
    
    override var intrinsicContentSize:CGSize { get { return CGSize(width:Constants.size, height:Constants.size) } }
    
    private func configureView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
        self.isUserInteractionEnabled = false
        self.backgroundColor = UIColor.clear
    }
    
    private func configureTrack() {
        let layer:CAShapeLayer = CAShapeLayer()
        layer.strokeColor = UIColor.groupTableViewBackground.cgColor
        layer.backgroundColor = nil
        layer.fillColor = nil
        layer.lineWidth = Constants.lineWidthTrack
        layer.path = self.arch(radius:Constants.radiusTrack)
        layer.lineCap = CAShapeLayerLineCap.square
        layer.frame = CGRect(x:0, y:0, width:Constants.size, height:Constants.size)
        self.track = layer
        self.layer.addSublayer(layer)
    }
    
    private func configureIndicator() {
        let layer:CAShapeLayer = CAShapeLayer()
        layer.strokeColor = UIColor.black.cgColor
        layer.backgroundColor = nil
        layer.fillColor = nil
        layer.lineWidth = Constants.lineWidthIndicator
        layer.path = self.arch(radius:Constants.radiusIndicator)
        layer.lineCap = CAShapeLayerLineCap.round
        layer.frame = CGRect(x:0, y:0, width:Constants.size, height:Constants.size)
        self.indicator = layer
        self.layer.addSublayer(layer)
    }
    
    private func animateIndicator() {
        let groupAnimation:CAAnimationGroup = CAAnimationGroup()
        groupAnimation.animations = [self.animationFirst(), self.animationSecond()]
        groupAnimation.duration = Constants.animationSecondDelay + Constants.animationSecondDuration
        groupAnimation.repeatCount = Float.infinity
        groupAnimation.isRemovedOnCompletion = false
        groupAnimation.fillMode = CAMediaTimingFillMode.forwards
        self.indicator.add(groupAnimation, forKey:Constants.animationKey)
    }
    
    private func animationFirst() -> CAAnimation {
        let animation:CABasicAnimation = CABasicAnimation(keyPath:Constants.animationKeypath)
        animation.duration = Constants.animationFirstDuration
        animation.timingFunction = CAMediaTimingFunction(controlPoints:0.4, 0.0, 0.2, 1.0)
        animation.fromValue = 0
        animation.toValue = 1
        return animation
    }
    
    private func animationSecond() -> CAAnimation {
        let animation:CABasicAnimation = CABasicAnimation(keyPath:Constants.animationKeypath)
        animation.beginTime = Constants.animationSecondDelay
        animation.duration = Constants.animationSecondDuration
        animation.fromValue = 1
        animation.toValue = 0
        return animation
    }
    
    private func arch(radius:CGFloat) -> CGPath {
        let path:UIBezierPath = UIBezierPath()
        path.addArc(withCenter:CGPoint(x:Constants.size / 2.0, y:Constants.size / 2.0), radius:radius,
                    startAngle:Constants.startAngle, endAngle:Constants.endAngle, clockwise:true)
        return path.cgPath
    }
}

private struct Constants {
    static let animationKey:String = "animation"
    static let animationKeypath:String = "strokeEnd"
    static let size:CGFloat = 100
    static let radiusTrack:CGFloat = 41
    static let radiusIndicator:CGFloat = 43
    static let startAngle:CGFloat = CGFloat.pi * 0.5
    static let endAngle:CGFloat = CGFloat.pi * 1.75
    static let lineWidthTrack:CGFloat = 2
    static let lineWidthIndicator:CGFloat = 4
    static let animationFirstDuration:TimeInterval = 1.5
    static let animationSecondDelay:TimeInterval = 15
    static let animationSecondDuration:TimeInterval = 0.2
}
