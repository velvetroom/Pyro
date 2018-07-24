import UIKit

class CreateContentView:UIView {
    weak var field:CreateFieldView!
    weak var icon:UIImageView!
    weak var border:UIView!
    weak var message:UILabel!
    
    init() {
        super.init(frame:CGRect.zero)
        self.backgroundColor = UIColor.white
        self.makeOutlets()
        self.layoutOutlets()
    }
    
    required init?(coder:NSCoder) {
        return nil
    }
    
    private func makeOutlets() {
        self.makeField()
        self.makeBorder()
        self.makeIcon()
        self.makeMessage()
    }
    
    private func layoutOutlets() {
        self.layoutField()
        self.layoutBorder()
        self.layoutIcon()
        self.layoutMessage()
    }
    
    private func makeField() {
        let field:CreateFieldView = CreateFieldView()
        self.field = field
        self.addSubview(field)
    }
    
    private func makeBorder() {
        let border:UIView = UIView()
        border.translatesAutoresizingMaskIntoConstraints = false
        border.isUserInteractionEnabled = false
        border.backgroundColor = UIColor.black
        self.border = border
        self.addSubview(border)
    }
    
    private func makeIcon() {
        let icon:UIImageView = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.isUserInteractionEnabled = false
        icon.contentMode = UIView.ContentMode.center
        icon.clipsToBounds = true
        self.icon = icon
        self.addSubview(icon)
    }
    
    private func makeMessage() {
        let message:UILabel = UILabel()
        message.translatesAutoresizingMaskIntoConstraints = false
        message.backgroundColor = UIColor.clear
        message.isUserInteractionEnabled = false
        message.font = UIFont.systemFont(ofSize:Constants.messageFontSize, weight:UIFont.Weight.regular)
        message.numberOfLines = 0
        message.textColor = UIColor(white:0, alpha:0.7)
        self.message = message
        self.addSubview(message)
    }
    
    private func layoutField() {
        self.field.leftAnchor.constraint(equalTo:self.leftAnchor, constant:Constants.margin).isActive = true
        if #available(iOS 11.0, *) {
            self.field.topAnchor.constraint(equalTo:self.safeAreaLayoutGuide.topAnchor,
                                            constant:Constants.margin).isActive = true
        } else {
            self.field.topAnchor.constraint(equalTo:self.topAnchor, constant:Constants.margin).isActive = true
        }
    }
    
    private func layoutBorder() {
        self.border.topAnchor.constraint(equalTo:self.field.bottomAnchor).isActive = true
        self.border.leftAnchor.constraint(equalTo:self.field.leftAnchor).isActive = true
        self.border.rightAnchor.constraint(equalTo:self.field.rightAnchor).isActive = true
        self.border.heightAnchor.constraint(equalToConstant:Constants.border).isActive = true
    }
    
    private func layoutIcon() {
        self.icon.widthAnchor.constraint(greaterThanOrEqualToConstant:0).isActive = true
        self.icon.heightAnchor.constraint(greaterThanOrEqualToConstant:0).isActive = true
        self.icon.leftAnchor.constraint(equalTo:self.field.rightAnchor, constant:Constants.margin).isActive = true
        self.icon.centerYAnchor.constraint(equalTo:self.field.centerYAnchor).isActive = true
    }
    
    private func layoutMessage() {
        self.message.leftAnchor.constraint(equalTo:self.field.leftAnchor).isActive = true
        self.message.rightAnchor.constraint(equalTo:self.rightAnchor, constant:-Constants.margin).isActive = true
        self.message.heightAnchor.constraint(greaterThanOrEqualToConstant:0).isActive = true
        self.message.topAnchor.constraint(equalTo:self.field.bottomAnchor, constant:Constants.margin).isActive = true
    }
}

private struct Constants {
    static let messageTop:CGFloat = 5
    static let margin:CGFloat = 20
    static let border:CGFloat = 1
    static let messageFontSize:CGFloat = 16
}
