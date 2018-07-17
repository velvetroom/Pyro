import UIKit

class StatsViewStreak:UIView {
    weak var labelAmount:UILabel!
    weak var labelTitle:UILabel!
    
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
        let labelAmount:UILabel = UILabel()
        labelAmount.translatesAutoresizingMaskIntoConstraints = false
        labelAmount.backgroundColor = UIColor.clear
        labelAmount.textColor = UIColor.black
        labelAmount.font = UIFont.systemFont(ofSize:Constants.amountFontSize, weight:UIFont.Weight.light)
        self.labelAmount = labelAmount
        self.addSubview(labelAmount)
    }
    
    private func makeTitle() {
        let labelTitle:UILabel = UILabel()
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.textColor = UIColor(white:0, alpha:0.3)
        labelTitle.font = UIFont.systemFont(ofSize:Constants.titleFontSize, weight:UIFont.Weight.regular)
        labelTitle.text = NSLocalizedString("StatsViewContent_StreakTitle", comment:String())
        self.labelTitle = labelTitle
        self.addSubview(labelTitle)
    }
    
    private func layoutAmount() {
        self.labelAmount.leftAnchor.constraint(equalTo:self.leftAnchor).isActive = true
        self.labelAmount.bottomAnchor.constraint(equalTo:self.labelTitle.topAnchor).isActive = true
        self.labelAmount.widthAnchor.constraint(greaterThanOrEqualToConstant:0).isActive = true
        self.labelAmount.heightAnchor.constraint(greaterThanOrEqualToConstant:0).isActive = true
    }
    
    private func layoutTitle() {
        self.labelTitle.leftAnchor.constraint(equalTo:self.leftAnchor).isActive = true
        self.labelTitle.bottomAnchor.constraint(equalTo:self.bottomAnchor).isActive = true
        self.labelTitle.widthAnchor.constraint(greaterThanOrEqualToConstant:0).isActive = true
        self.labelTitle.heightAnchor.constraint(greaterThanOrEqualToConstant:0).isActive = true
    }
}

private struct Constants {
    static let amountFontSize:CGFloat = 70
    static let titleFontSize:CGFloat = 14
}
