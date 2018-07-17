import UIKit

class StatsViewStat:UIView {
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
    
    override func layoutSubviews() {
        self.intrinsicContentSize = CGSize(width:max(self.labelAmount.bounds.width, self.labelTitle.bounds.width),
                                           height:self.labelTitle.bounds.maxY)
        super.layoutSubviews()
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
        labelAmount.textAlignment = NSTextAlignment.center
        labelAmount.textColor = UIColor.black
        self.labelAmount = labelAmount
        self.addSubview(labelAmount)
    }
    
    private func makeTitle() {
        let labelTitle:UILabel = UILabel()
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.textAlignment = NSTextAlignment.right
        labelTitle.textColor = UIColor(white:0, alpha:0.2)
        labelTitle.font = UIFont.systemFont(ofSize:Constants.titleFontSize, weight:UIFont.Weight.bold)
        self.labelTitle = labelTitle
        self.addSubview(labelTitle)
    }
    
    private func layoutAmount() {
        self.labelAmount.centerXAnchor.constraint(equalTo:self.centerXAnchor).isActive = true
        self.labelAmount.topAnchor.constraint(equalTo:self.topAnchor).isActive = true
    }
    
    private func layoutTitle() {
        self.labelTitle.rightAnchor.constraint(equalTo:self.labelAmount.rightAnchor).isActive = true
        self.labelTitle.topAnchor.constraint(equalTo:self.labelAmount.bottomAnchor,
                                             constant:Constants.titleTop).isActive = true
    }
}

private struct Constants {
    static let titleFontSize:CGFloat = 12
    static let titleTop:CGFloat = 2
}
