import UIKit

class StatsViewContent:UIView {
    weak var viewSpin:LoadingView!
    weak var labelStreak:UILabel!
    
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
        self.backgroundColor = UIColor.white
    }
    
    private func makeOutlets() {
        self.makeSpin()
        self.makeStreak()
    }
    
    private func layoutOutlets() {
        self.layoutSpin()
        self.layoutStreak()
    }
    
    private func makeSpin() {
        let viewSpin:LoadingView = LoadingView()
        viewSpin.tintColor = UIColor.black
        self.viewSpin = viewSpin
        self.addSubview(viewSpin)
    }
    
    private func makeStreak() {
        let labelStreak:UILabel = UILabel()
        labelStreak.translatesAutoresizingMaskIntoConstraints = false
        labelStreak.backgroundColor = UIColor.clear
        labelStreak.textAlignment = NSTextAlignment.right
        labelStreak.textColor = UIColor.black
        labelStreak.font = UIFont.systemFont(ofSize:Constants.streakFontSize, weight:UIFont.Weight.light)
        self.labelStreak = labelStreak
        self.addSubview(labelStreak)
    }
    
    private func layoutSpin() {
        self.viewSpin.centerXAnchor.constraint(equalTo:self.centerXAnchor).isActive = true
        self.viewSpin.centerYAnchor.constraint(equalTo:self.centerYAnchor).isActive = true
    }
    
    private func layoutStreak() {
        self.labelStreak.rightAnchor.constraint(equalTo:self.rightAnchor,
                                                constant:Constants.streakRight).isActive = true
        self.labelStreak.topAnchor.constraint(equalTo:self.topAnchor, constant:Constants.streakTop).isActive = true
        self.labelStreak.widthAnchor.constraint(greaterThanOrEqualToConstant:0).isActive = true
        self.labelStreak.heightAnchor.constraint(greaterThanOrEqualToConstant:0).isActive = true
    }
}

private struct Constants {
    static let spinTop:CGFloat = 100
    static let streakFontSize:CGFloat = 50
    static let streakRight:CGFloat = -20
    static let streakTop:CGFloat = 90
}
