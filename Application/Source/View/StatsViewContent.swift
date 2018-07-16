import UIKit

class StatsViewContent:UIView {
    weak var viewSpin:StatsViewSpin!
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
        let viewSpin:StatsViewSpin = StatsViewSpin()
        self.viewSpin = viewSpin
        self.addSubview(viewSpin)
    }
    
    private func makeStreak() {
        let labelStreak:UILabel = UILabel()
        self.labelStreak = labelStreak
        self.addSubview(labelStreak)
    }
    
    private func layoutSpin() {
        self.viewSpin.centerXAnchor.constraint(equalTo:self.centerXAnchor).isActive = true
        self.viewSpin.centerYAnchor.constraint(equalTo:self.centerYAnchor).isActive = true
    }
    
    private func layoutStreak() {
        
    }
}
