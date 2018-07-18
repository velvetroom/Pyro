import UIKit

class StatsContentView:UIView {
    weak var streak:StatsStreakView!
    weak var contributions:StatsContributionsView!
    weak var histogram:HistogramView!
    
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
        self.makeHistogram()
        self.makeStreak()
        self.makeContributions()
    }
    
    private func layoutOutlets() {
        self.layoutHistogram()
        self.layoutStreak()
        self.layoutContributions()
    }
    
    private func makeStreak() {
        let viewStreak:StatsStreakView = StatsStreakView()
        self.streak = viewStreak
        self.addSubview(viewStreak)
    }
    
    private func makeContributions() {
        let viewContributions:StatsContributionsView = StatsContributionsView()
        self.contributions = viewContributions
        self.addSubview(viewContributions)
    }
    
    private func makeHistogram() {
        let histogram:HistogramView = HistogramView()
        self.histogram = histogram
        self.addSubview(histogram)
    }
    
    private func layoutStreak() {
        self.streak.leftAnchor.constraint(equalTo:self.leftAnchor, constant:Constants.margin).isActive = true
        self.streak.rightAnchor.constraint(equalTo:self.rightAnchor).isActive = true
        self.streak.heightAnchor.constraint(equalToConstant:Constants.statHeight).isActive = true
        if #available(iOS 11.0, *) {
            self.streak.topAnchor.constraint(equalTo:self.safeAreaLayoutGuide.topAnchor).isActive = true
        } else {
            self.streak.topAnchor.constraint(equalTo:self.topAnchor).isActive = true
        }
    }
    
    private func layoutContributions() {
        self.contributions.bottomAnchor.constraint(equalTo:self.streak.bottomAnchor).isActive = true
        self.contributions.rightAnchor.constraint(equalTo:self.rightAnchor,
                                                      constant:-Constants.margin).isActive = true
        self.contributions.leftAnchor.constraint(equalTo:self.leftAnchor).isActive = true
        self.contributions.heightAnchor.constraint(equalToConstant:Constants.statHeight).isActive = true
    }
    
    private func layoutHistogram() {
        self.histogram.leftAnchor.constraint(equalTo:self.leftAnchor).isActive = true
        self.histogram.rightAnchor.constraint(equalTo:self.rightAnchor).isActive = true
        self.histogram.heightAnchor.constraint(equalToConstant:Constants.histogramHeight).isActive = true
        if #available(iOS 11.0, *) {
            self.histogram.bottomAnchor.constraint(equalTo:self.safeAreaLayoutGuide.bottomAnchor).isActive = true
        } else {
            self.histogram.bottomAnchor.constraint(equalTo:self.bottomAnchor).isActive = true
        }
    }
}

private struct Constants {
    static let statHeight:CGFloat = 110
    static let margin:CGFloat = 20
    static let histogramHeight:CGFloat = 300
}
