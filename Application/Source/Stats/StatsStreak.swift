import UIKit

class StatsStreak:UIView {
    weak var amount:UILabel!
    weak var title:UILabel!
    
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
        self.makeAmount()
        self.makeTitle()
    }
    
    private func layoutOutlets() {
        self.layoutAmount()
        self.layoutTitle()
    }
    
    private func makeAmount() {
        let amount:UILabel = UILabel()
        amount.translatesAutoresizingMaskIntoConstraints = false
        amount.backgroundColor = UIColor.clear
        amount.textColor = UIColor.black
        amount.font = UIFont.systemFont(ofSize:Constants.amountFontSize, weight:UIFont.Weight.light)
        self.amount = amount
        self.addSubview(amount)
    }
    
    private func makeTitle() {
        let title:UILabel = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.backgroundColor = UIColor.clear
        title.textColor = UIColor(white:0, alpha:0.3)
        title.font = UIFont.systemFont(ofSize:Constants.titleFontSize, weight:UIFont.Weight.regular)
        title.text = NSLocalizedString("StatsViewContent_StreakTitle", comment:String())
        self.title = title
        self.addSubview(title)
    }
    
    private func layoutAmount() {
        self.amount.leftAnchor.constraint(equalTo:self.leftAnchor).isActive = true
        self.amount.bottomAnchor.constraint(equalTo:self.title.topAnchor).isActive = true
        self.amount.widthAnchor.constraint(greaterThanOrEqualToConstant:0).isActive = true
        self.amount.heightAnchor.constraint(greaterThanOrEqualToConstant:0).isActive = true
    }
    
    private func layoutTitle() {
        self.title.leftAnchor.constraint(equalTo:self.leftAnchor).isActive = true
        self.title.bottomAnchor.constraint(equalTo:self.bottomAnchor).isActive = true
        self.title.widthAnchor.constraint(greaterThanOrEqualToConstant:0).isActive = true
        self.title.heightAnchor.constraint(greaterThanOrEqualToConstant:0).isActive = true
    }
}

private struct Constants {
    static let amountFontSize:CGFloat = 70
    static let titleFontSize:CGFloat = 14
}
