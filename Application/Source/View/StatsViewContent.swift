import UIKit

class StatsViewContent:UIView {
    weak var viewStreak:StatsViewStreak!
    weak var viewContributions:StatsViewContributions!
    
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
        let viewStreak:StatsViewStreak = StatsViewStreak()
        self.viewStreak = viewStreak
        self.addSubview(viewStreak)
    }
    
    private func makeContributions() {
        let viewContributions:StatsViewContributions = StatsViewContributions()
        self.viewContributions = viewContributions
        self.addSubview(viewContributions)
    }
    
    private func layoutStreak() {
        self.viewStreak.topAnchor.constraint(equalTo:self.topAnchor).isActive = true
        self.viewStreak.leftAnchor.constraint(equalTo:self.leftAnchor, constant:Constants.margin).isActive = true
        self.viewStreak.widthAnchor.constraint(equalToConstant:Constants.statWidth).isActive = true
        self.viewStreak.heightAnchor.constraint(equalToConstant:Constants.statHeight).isActive = true
    }
    
    private func layoutContributions() {
        self.viewContributions.bottomAnchor.constraint(equalTo:self.viewStreak.bottomAnchor).isActive = true
        self.viewContributions.rightAnchor.constraint(equalTo:self.rightAnchor,
                                                      constant:-Constants.margin).isActive = true
        self.viewContributions.widthAnchor.constraint(equalToConstant:Constants.statWidth).isActive = true
        self.viewContributions.heightAnchor.constraint(equalToConstant:Constants.statHeight).isActive = true
    }
}

private struct Constants {
    static let statWidth:CGFloat = 150
    static let statHeight:CGFloat = 170
    static let margin:CGFloat = 20
}
