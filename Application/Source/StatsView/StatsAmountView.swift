import UIKit

class StatsAmountView:UIView {
    weak var streak:UILabel!
    weak var contributions:UILabel!
    weak var titleStreak:UILabel!
    weak var titleContributions:UILabel!
    
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
        self.isUserInteractionEnabled = false
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
    }
    
    private func makeOutlets() {
        self.makeStreak()
        self.makeTitleStreak()
        self.makeContributions()
        self.makeTitleContributions()
    }
    
    private func layoutOutlets() {
        self.layoutStreak()
        self.layoutTitleStreak()
        self.layoutContributions()
        self.layoutTitleContributions()
    }
    
    private func makeStreak() {
        let streak:UILabel = UILabel()
        streak.translatesAutoresizingMaskIntoConstraints = false
        streak.backgroundColor = UIColor.clear
        streak.textColor = UIColor.black
        streak.font = UIFont.systemFont(ofSize:Constants.streakFontSize, weight:UIFont.Weight.light)
        self.streak = streak
        self.addSubview(streak)
    }
    
    private func makeTitleStreak() {
        let titleStreak:UILabel = self.makeTitle()
        titleStreak.text = NSLocalizedString("StatsViewContent_StreakTitle", comment:String())
        self.titleStreak = titleStreak
        self.addSubview(titleStreak)
    }
    
    private func makeContributions() {
        let contributions:UILabel = UILabel()
        contributions.translatesAutoresizingMaskIntoConstraints = false
        contributions.backgroundColor = UIColor.clear
        contributions.textColor = UIColor.black
        contributions.font = UIFont.systemFont(ofSize:Constants.contributionsFontSize, weight:UIFont.Weight.light)
        contributions.textAlignment = NSTextAlignment.right
        self.contributions = contributions
        self.addSubview(contributions)
    }
    
    private func makeTitleContributions() {
        let titleContributions:UILabel = self.makeTitle()
        titleContributions.text = NSLocalizedString("StatsViewContent_ContributionsTitle", comment:String())
        self.titleContributions = titleContributions
        self.addSubview(titleContributions)
    }
    
    private func makeTitle() -> UILabel {
        let title:UILabel = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.backgroundColor = UIColor.clear
        title.textColor = UIColor(white:0, alpha:0.3)
        title.font = UIFont.systemFont(ofSize:Constants.titleFontSize, weight:UIFont.Weight.regular)
        return title
    }
    
    private func layoutStreak() {
        self.streak.leftAnchor.constraint(equalTo:self.leftAnchor, constant:Constants.margin).isActive = true
        self.streak.bottomAnchor.constraint(equalTo:self.titleStreak.topAnchor).isActive = true
        self.streak.widthAnchor.constraint(greaterThanOrEqualToConstant:0).isActive = true
        self.streak.heightAnchor.constraint(greaterThanOrEqualToConstant:0).isActive = true
    }
    
    private func layoutTitleStreak() {
        self.titleStreak.leftAnchor.constraint(equalTo:self.leftAnchor, constant:Constants.margin).isActive = true
        self.titleStreak.bottomAnchor.constraint(equalTo:self.bottomAnchor).isActive = true
        self.titleStreak.widthAnchor.constraint(greaterThanOrEqualToConstant:0).isActive = true
        self.titleStreak.heightAnchor.constraint(greaterThanOrEqualToConstant:0).isActive = true
    }
    
    private func layoutContributions() {
        self.contributions.rightAnchor.constraint(equalTo:self.rightAnchor, constant:-Constants.margin).isActive = true
        self.contributions.bottomAnchor.constraint(equalTo:self.titleContributions.topAnchor).isActive = true
        self.contributions.widthAnchor.constraint(greaterThanOrEqualToConstant:0).isActive = true
        self.contributions.heightAnchor.constraint(greaterThanOrEqualToConstant:0).isActive = true
    }
    
    private func layoutTitleContributions() {
        self.titleContributions.rightAnchor.constraint(equalTo:self.rightAnchor,
                                                       constant:-Constants.margin).isActive = true
        self.titleContributions.bottomAnchor.constraint(equalTo:self.bottomAnchor).isActive = true
        self.titleContributions.widthAnchor.constraint(greaterThanOrEqualToConstant:0).isActive = true
        self.titleContributions.heightAnchor.constraint(greaterThanOrEqualToConstant:0).isActive = true
    }
}

private struct Constants {
    static let streakFontSize:CGFloat = 70
    static let contributionsFontSize:CGFloat = 32
    static let titleFontSize:CGFloat = 14
    static let margin:CGFloat = 20
}
