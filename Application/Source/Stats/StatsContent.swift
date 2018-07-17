import UIKit

class StatsContent:UIView {
    weak var streak:StatsStreak!
    weak var contributions:StatsContributions!
    weak var histogram:Histogram!
    
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
        self.makeHistogram()
    }
    
    private func layoutOutlets() {
        self.layoutStreak()
        self.layoutContributions()
        self.layoutHistogram()
    }
    
    private func makeStreak() {
        let viewStreak:StatsStreak = StatsStreak()
        self.streak = viewStreak
        self.addSubview(viewStreak)
    }
    
    private func makeContributions() {
        let viewContributions:StatsContributions = StatsContributions()
        self.contributions = viewContributions
        self.addSubview(viewContributions)
    }
    
    private func makeHistogram() {
        let histogram:Histogram = Histogram()
        self.histogram = histogram
        self.addSubview(histogram)
    }
    
    private func layoutStreak() {
        self.streak.topAnchor.constraint(equalTo:self.topAnchor).isActive = true
        self.streak.leftAnchor.constraint(equalTo:self.leftAnchor, constant:Constants.margin).isActive = true
        self.streak.widthAnchor.constraint(equalToConstant:Constants.statWidth).isActive = true
        self.streak.heightAnchor.constraint(equalToConstant:Constants.statHeight).isActive = true
    }
    
    private func layoutContributions() {
        self.contributions.bottomAnchor.constraint(equalTo:self.streak.bottomAnchor).isActive = true
        self.contributions.rightAnchor.constraint(equalTo:self.rightAnchor,
                                                      constant:-Constants.margin).isActive = true
        self.contributions.widthAnchor.constraint(equalToConstant:Constants.statWidth).isActive = true
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
    static let statWidth:CGFloat = 150
    static let statHeight:CGFloat = 170
    static let margin:CGFloat = 20
    static let histogramHeight:CGFloat = 300
}
