import UIKit

class CreateFieldView:UITextField {
    init() {
        super.init(frame:CGRect.zero)
        self.configureView()
    }
    
    required init?(coder:NSCoder) { return nil }
    override var intrinsicContentSize:CGSize { get { return CGSize(width:Constants.width, height:Constants.height) } }
    
    private func configureView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.clear
        self.font = UIFont.systemFont(ofSize:Constants.fontSize, weight:UIFont.Weight.light)
        self.textColor = UIColor.black
        self.tintColor = UIColor.black
        self.autocapitalizationType = UITextAutocapitalizationType.none
        self.autocorrectionType = UITextAutocorrectionType.no
        self.returnKeyType = UIReturnKeyType.done
        self.spellCheckingType = UITextSpellCheckingType.no
        self.borderStyle = UITextField.BorderStyle.none
        self.clearButtonMode = UITextField.ViewMode.never
        self.clearsOnBeginEditing = false
        self.clearsOnInsertion = false
        self.keyboardAppearance = UIKeyboardAppearance.light
        self.keyboardType = UIKeyboardType.alphabet
    }
}

private struct Constants {
    static let fontSize:CGFloat = 26
    static let width:CGFloat = 200
    static let height:CGFloat = 40
}
