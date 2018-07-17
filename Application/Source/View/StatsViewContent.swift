import UIKit

class StatsViewContent:UIView {
    weak var viewStreak:StatsViewStat!
    weak var viewContributions:StatsViewStat!
    
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
        self.makeStreak()
        self.makeContributions()
    }
    
    private func layoutOutlets() {
        self.layoutStreak()
        self.layoutContributions()
    }
    
    private func makeStreak() {
        let viewStreak:StatsViewStat = StatsViewStat()
        viewStreak.labelAmount.font = UIFont.systemFont(ofSize:Constants.streakFontSize, weight:UIFont.Weight.light)
        viewStreak.labelTitle.text = NSLocalizedString("StatsViewContent_StreakTitle", comment:String())
        self.viewStreak = viewStreak
        self.addSubview(viewStreak)
    }
    
    private func makeContributions() {
        let viewContributions:StatsViewStat = StatsViewStat()
        viewContributions.labelAmount.font = UIFont.systemFont(ofSize:Constants.statFontSize,
                                                               weight:UIFont.Weight.light)
        viewContributions.labelTitle.text = NSLocalizedString("StatsViewContent_ContributionsTitle", comment:String())
        self.viewContributions = viewContributions
        self.addSubview(viewContributions)
    }
    
    private func layoutStreak() {
        self.viewStreak.topAnchor.constraint(equalTo:self.topAnchor, constant:Constants.streakTop).isActive = true
        self.viewStreak.centerXAnchor.constraint(equalTo:self.centerXAnchor).isActive = true
    }
    
    private func layoutContributions() {
        self.viewContributions.topAnchor.constraint(equalTo:self.viewStreak.bottomAnchor,
                                             constant:Constants.statMargin).isActive = true
        self.viewContributions.leftAnchor.constraint(equalTo:self.leftAnchor,
                                                     constant:Constants.statMargin).isActive = true
    }
}

private struct Constants {
    static let streakTop:CGFloat = 80
    static let statMargin:CGFloat = 20
    static let streakFontSize:CGFloat = 35
    static let statFontSize:CGFloat = 25
}
