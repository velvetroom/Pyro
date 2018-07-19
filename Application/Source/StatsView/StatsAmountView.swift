import UIKit

class StatsAmountView:UIView {
    weak var streak:UILabel!
    weak var contributions:UILabel!
    
    init() {
        super.init(frame:CGRect.zero)
        self.configureView()
        self.makeOutlets()
        self.layoutOutlets()
    }
    
    required init?(coder:NSCoder) { return nil }
    override var intrinsicContentSize:CGSize { get { return CGSize(width:UIView.noIntrinsicMetric,
                                                                   height:Constants.height) } }
    
    private func configureView() {
        self.isUserInteractionEnabled = false
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
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
        let streak:UILabel = UILabel()
        streak.translatesAutoresizingMaskIntoConstraints = false
        streak.backgroundColor = UIColor.clear
        streak.numberOfLines = 0
        self.streak = streak
        self.addSubview(streak)
    }
    
    private func makeContributions() {
        let contributions:UILabel = UILabel()
        contributions.translatesAutoresizingMaskIntoConstraints = false
        contributions.backgroundColor = UIColor.clear
        contributions.numberOfLines = 0
        contributions.textAlignment = NSTextAlignment.right
        self.contributions = contributions
        self.addSubview(contributions)
    }
    
    private func layoutStreak() {
        self.streak.leftAnchor.constraint(equalTo:self.leftAnchor, constant:Constants.margin).isActive = true
        self.streak.bottomAnchor.constraint(equalTo:self.bottomAnchor).isActive = true
        self.streak.widthAnchor.constraint(greaterThanOrEqualToConstant:0).isActive = true
        self.streak.heightAnchor.constraint(greaterThanOrEqualToConstant:0).isActive = true
    }
    
    private func layoutContributions() {
        self.contributions.rightAnchor.constraint(equalTo:self.rightAnchor, constant:-Constants.margin).isActive = true
        self.contributions.bottomAnchor.constraint(equalTo:self.bottomAnchor).isActive = true
        self.contributions.widthAnchor.constraint(greaterThanOrEqualToConstant:0).isActive = true
        self.contributions.heightAnchor.constraint(greaterThanOrEqualToConstant:0).isActive = true
    }
}

private struct Constants {
    static let margin:CGFloat = 10
    static let height:CGFloat = 92
}
