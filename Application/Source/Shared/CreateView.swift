import UIKit

class CreateView:UIAlertController, UITextFieldDelegate {
    weak var presenter:UsersPresenter?
    private weak var name:UITextField!
    private weak var url:UITextField!
    private weak var accept:UIAlertAction!
    
    func configureView() {
        self.title = NSLocalizedString("UsersViewNew_Title", comment:String())
        self.message = NSLocalizedString("UsersViewNew_Message", comment:String())
        self.makeOutlets()
    }
    
    func textField(_:UITextField, shouldChangeCharactersIn:NSRange, replacementString:String) -> Bool {
        if self.name.text!.isEmpty || self.url.text!.isEmpty {
            self.accept.isEnabled = false
        } else {
            self.accept.isEnabled = true
        }
        return true
    }
    
    private func makeOutlets() {
        let accept:UIAlertAction = UIAlertAction(title:NSLocalizedString("UsersViewNew_Add", comment:String()),
                                    style:UIAlertAction.Style.default, handler:
        { [weak self] (action:UIAlertAction) in
            self?.createUser()
        })
        accept.isEnabled = false
        self.accept = accept
        self.addTextField { [weak self] (field:UITextField) in
            field.placeholder = NSLocalizedString("UsersViewNew_Name", comment:String())
            self?.configure(field:field)
            self?.name = field
        }
        self.addTextField { [weak self] (field:UITextField) in
            field.placeholder = NSLocalizedString("UsersViewNew_Url", comment:String())
            self?.configure(field:field)
            self?.url = field
        }
        self.addAction(accept)
        self.addAction(UIAlertAction(title:NSLocalizedString("UsersViewNew_Cancel", comment:String()),
                                     style:UIAlertAction.Style.cancel, handler:nil))
    }
    
    private func configure(field:UITextField) {
        field.autocapitalizationType = UITextAutocapitalizationType.words
        field.autocorrectionType = UITextAutocorrectionType.no
        field.spellCheckingType = UITextSpellCheckingType.no
        field.font = UIFont.systemFont(ofSize:Constants.fontSize, weight:UIFont.Weight.medium)
        field.borderStyle = UITextField.BorderStyle.none
        field.delegate = self
    }
    
    private func createUser() {
        self.presenter?.add(name:self.name.text!, url:self.url.text!)
    }
}

private struct Constants {
    static let fontSize:CGFloat = 20
}
