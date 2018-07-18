import UIKit
import Pyro

class StatsTitleView:UILabel {
    init() {
        super.init(frame:CGRect(x:0, y:0, width:Constants.width, height:Constants.height))
        self.configureView()
    }
    
    required init?(coder:NSCoder) { return nil }
    
    func configure(user:User) {
        let string:NSMutableAttributedString = NSMutableAttributedString()
        string.append(NSAttributedString(string:user.name, attributes:[NSAttributedString.Key.font:
            UIFont.systemFont(ofSize:Constants.titleFontSize, weight:UIFont.Weight.regular)]))
        string.append(NSAttributedString(string:"\n\(user.url)", attributes:[NSAttributedString.Key.font:
            UIFont.systemFont(ofSize:Constants.subtitleFontSize, weight:UIFont.Weight.light)]))
        self.attributedText = string
    }
    
    private func configureView() {
        self.numberOfLines = 0
        self.textColor = UIColor.black
        self.backgroundColor = UIColor.clear
    }
}

private struct Constants {
    static let width:CGFloat = 2000
    static let height:CGFloat = 44
    static let titleFontSize:CGFloat = 14
    static let subtitleFontSize:CGFloat = 10
}
