import UIKit

class StatsViewCell:UICollectionViewCell {
    weak var labelName:UILabel!
    weak var labelValue:UILabel!
    
    override init(frame:CGRect) {
        super.init(frame:CGRect.zero)
        self.makeOutlets()
        self.layoutOutlets()
        self.configureView()
    }
    
    required init?(coder:NSCoder) {
        return nil
    }
    
    private func configureView() {
        self.backgroundColor = UIColor.white
        self.isUserInteractionEnabled = false
    }
    
    private func makeOutlets() {
        self.makeName()
        self.makeValue()
    }
    
    private func layoutOutlets() {
        self.layoutName()
        self.layoutValue()
    }
    
    private func makeName() {
        let labelName:UILabel = UILabel()
        labelName.translatesAutoresizingMaskIntoConstraints = false
        labelName.isUserInteractionEnabled = false
        labelName.backgroundColor = UIColor.clear
        labelName.numberOfLines = 0
        labelName.textColor = UIColor.black
        labelName.font = UIFont.systemFont(ofSize:Constants.nameFontSize, weight:UIFont.Weight.bold)
        self.labelName = labelName
        self.contentView.addSubview(labelName)
    }
    
    private func makeValue() {
        let labelValue:UILabel = UILabel()
        labelValue.translatesAutoresizingMaskIntoConstraints = false
        labelValue.isUserInteractionEnabled = false
        labelValue.backgroundColor = UIColor.clear
        labelValue.numberOfLines = 0
        labelValue.textColor = self.tintColor
        labelValue.font = UIFont.systemFont(ofSize:Constants.valueFontSize, weight:UIFont.Weight.medium)
        self.labelValue = labelValue
        self.contentView.addSubview(labelValue)
    }
    
    private func layoutName() {
        self.labelName.topAnchor.constraint(equalTo:self.topAnchor, constant:Constants.marginVertical).isActive = true
        self.labelName.leftAnchor.constraint(equalTo:self.leftAnchor,
                                             constant:Constants.marginHorizontal).isActive = true
        self.labelName.rightAnchor.constraint(equalTo:self.rightAnchor,
                                              constant:-Constants.marginHorizontal).isActive = true
        self.labelName.heightAnchor.constraint(greaterThanOrEqualToConstant:0).isActive = true
    }
    
    private func layoutValue() {
        self.labelValue.bottomAnchor.constraint(equalTo:self.bottomAnchor,
                                                constant:-Constants.marginVertical).isActive = true
        self.labelValue.leftAnchor.constraint(equalTo:self.leftAnchor,
                                              constant:Constants.marginHorizontal).isActive = true
        self.labelValue.rightAnchor.constraint(equalTo:self.rightAnchor,
                                               constant:-Constants.marginHorizontal).isActive = true
        self.labelValue.heightAnchor.constraint(greaterThanOrEqualToConstant:0).isActive = true
    }
}

private struct Constants {
    static let nameFontSize:CGFloat = 14
    static let valueFontSize:CGFloat = 14
    static let marginHorizontal:CGFloat = 18
    static let marginVertical:CGFloat = 12
}