import UIKit

class HistogramMonth:UIView {
    weak var name:UILabel!
    
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
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func makeOutlets() {
        let name:UILabel = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.isUserInteractionEnabled = false
        name.backgroundColor = UIColor.clear
        name.textAlignment = NSTextAlignment.center
        name.textColor = UIColor.black
        name.font = UIFont.systemFont(ofSize:Constants.fontSize, weight:UIFont.Weight.light)
        name.text = "Jan"
        self.name = name
        self.addSubview(name)
    }
    
    private func layoutOutlets() {
        self.name.leftAnchor.constraint(equalTo:self.leftAnchor).isActive = true
        self.name.rightAnchor.constraint(equalTo:self.rightAnchor).isActive = true
        self.name.bottomAnchor.constraint(equalTo:self.bottomAnchor, constant:Constants.nameBottom).isActive = true
        self.name.heightAnchor.constraint(greaterThanOrEqualToConstant:0).isActive = true
    }
}

private struct Constants {
    static let fontSize:CGFloat = 10
    static let nameBottom:CGFloat = -5
}
