import UIKit
import CleanArchitecture

class CreateView:View<CreatePresenter>, UITextFieldDelegate {
    weak var field:UITextField!
    weak var icon:UIImageView!
    weak var border:UIView!
    weak var message:UILabel!
    weak var bio:UILabel!
    weak var loading:LoadingView!
    weak var saveButton:UIBarButtonItem!
    
    override func viewDidLoad() {
        self.configureView()
        self.makeOutlets()
        self.layoutOutlets()
        self.configureViewModel()
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated:Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setToolbarHidden(true, animated:false)
    }
    
    override func viewDidAppear(_ animated:Bool) {
        super.viewDidAppear(animated)
        self.field.becomeFirstResponder()
    }
    
    func textField(_:UITextField, shouldChangeCharactersIn range:NSRange, replacementString string:String) -> Bool {
        let current:String = self.field.text!
        self.presenter.validate(url:current.replacingCharacters(in:Range(range, in:current)!, with:string))
        return true
    }
    
    func textFieldShouldReturn(_:UITextField) -> Bool {
        self.field.resignFirstResponder()
        return true
    }

    private func configureView() {
        self.view.backgroundColor = UIColor.white
        self.title = NSLocalizedString("CreateView.title", comment:String())
        let saveButton:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem:UIBarButtonItem.SystemItem.save,
                                                         target:self, action:#selector(self.selectorSave))
        self.saveButton = saveButton
        self.navigationItem.rightBarButtonItem = saveButton
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem:UIBarButtonItem.SystemItem.cancel,
                                                                 target:self, action:#selector(self.selectorCancel))
    }
    
    private func makeOutlets() {
        let field:UITextField = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.backgroundColor = UIColor.clear
        field.font = UIFont.systemFont(ofSize:Constants.fieldFont, weight:UIFont.Weight.light)
        field.textColor = UIColor.black
        field.tintColor = UIColor.black
        field.autocapitalizationType = UITextAutocapitalizationType.none
        field.autocorrectionType = UITextAutocorrectionType.no
        field.returnKeyType = UIReturnKeyType.done
        field.spellCheckingType = UITextSpellCheckingType.no
        field.borderStyle = UITextField.BorderStyle.none
        field.clearButtonMode = UITextField.ViewMode.never
        field.clearsOnBeginEditing = false
        field.clearsOnInsertion = false
        field.keyboardAppearance = UIKeyboardAppearance.light
        field.keyboardType = UIKeyboardType.alphabet
        field.delegate = self
        self.field = field
        self.view.addSubview(field)
        
        let border:UIView = UIView()
        border.translatesAutoresizingMaskIntoConstraints = false
        border.isUserInteractionEnabled = false
        border.backgroundColor = UIColor.black
        self.border = border
        self.view.addSubview(border)
        
        let icon:UIImageView = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.isUserInteractionEnabled = false
        icon.contentMode = UIView.ContentMode.center
        icon.clipsToBounds = true
        self.icon = icon
        self.view.addSubview(icon)
        
        let message:UILabel = UILabel()
        message.translatesAutoresizingMaskIntoConstraints = false
        message.isUserInteractionEnabled = false
        message.font = UIFont.systemFont(ofSize:Constants.messageFont, weight:UIFont.Weight.light)
        message.numberOfLines = 0
        message.textColor = UIColor(white:0, alpha:0.6)
        self.message = message
        self.view.addSubview(message)
        
        let bio:UILabel = UILabel()
        bio.translatesAutoresizingMaskIntoConstraints = false
        bio.isUserInteractionEnabled = false
        bio.numberOfLines = 0
        bio.textColor = UIColor.black
        self.bio = bio
        self.view.addSubview(bio)
        
        let loading:LoadingView = LoadingView()
        loading.tintColor = UIColor.sharedBlue
        self.loading = loading
        self.view.addSubview(loading)
    }
    
    private func layoutOutlets() {
        self.field.leftAnchor.constraint(equalTo:self.view.leftAnchor, constant:Constants.margin).isActive = true
        self.field.widthAnchor.constraint(equalToConstant:Constants.fieldWidth).isActive = true
        self.field.heightAnchor.constraint(equalToConstant:Constants.fieldHeight).isActive = true
        
        self.border.topAnchor.constraint(equalTo:self.field.bottomAnchor).isActive = true
        self.border.leftAnchor.constraint(equalTo:self.field.leftAnchor).isActive = true
        self.border.rightAnchor.constraint(equalTo:self.field.rightAnchor).isActive = true
        self.border.heightAnchor.constraint(equalToConstant:Constants.border).isActive = true
        
        self.icon.widthAnchor.constraint(greaterThanOrEqualToConstant:0).isActive = true
        self.icon.heightAnchor.constraint(greaterThanOrEqualToConstant:0).isActive = true
        self.icon.centerXAnchor.constraint(equalTo:self.field.rightAnchor, constant:Constants.iconLeft).isActive = true
        self.icon.centerYAnchor.constraint(equalTo:self.border.centerYAnchor).isActive = true
        
        self.message.leftAnchor.constraint(equalTo:self.field.leftAnchor).isActive = true
        self.message.rightAnchor.constraint(equalTo:self.field.rightAnchor).isActive = true
        self.message.topAnchor.constraint(equalTo:self.field.bottomAnchor,
                                          constant:Constants.messageTop).isActive = true
        self.message.heightAnchor.constraint(greaterThanOrEqualToConstant:0).isActive = true
        
        self.bio.topAnchor.constraint(equalTo:self.message.bottomAnchor, constant:Constants.margin).isActive = true
        self.bio.leftAnchor.constraint(equalTo:self.view.leftAnchor, constant:Constants.margin).isActive = true
        self.bio.rightAnchor.constraint(equalTo:self.view.rightAnchor, constant:-Constants.margin).isActive = true
        self.bio.heightAnchor.constraint(greaterThanOrEqualToConstant:0).isActive = true
        
        self.loading.centerXAnchor.constraint(equalTo:self.icon.centerXAnchor).isActive = true
        self.loading.centerYAnchor.constraint(equalTo:self.icon.centerYAnchor).isActive = true
        
        if #available(iOS 11.0, *) {
            self.navigationItem.largeTitleDisplayMode = UINavigationItem.LargeTitleDisplayMode.always
            self.field.topAnchor.constraint(equalTo:self.view.safeAreaLayoutGuide.topAnchor,
                                            constant:Constants.margin).isActive = true
        } else {
            self.field.topAnchor.constraint(equalTo:self.view.topAnchor, constant:Constants.margin).isActive = true
        }
    }
    
    private func configureViewModel() {
        self.presenter.viewModels.observe { [weak self] (viewModel:CreateViewModel) in
            self?.saveButton.isEnabled = viewModel.saveEnabled
            self?.message.text = viewModel.message
            self?.icon.image = viewModel.icon
            self?.loading.isHidden = viewModel.loadingHidden
            self?.bio.attributedText = viewModel.bio
        }
    }
    
    @objc private func selectorSave() {
        self.field.resignFirstResponder()
        self.presenter.save()
    }
    
    @objc private func selectorCancel() {
        self.field.resignFirstResponder()
        self.presenter.cancel()
    }
}

private struct Constants {
    static let margin:CGFloat = 20
    static let border:CGFloat = 1
    static let messageFont:CGFloat = 15
    static let messageTop:CGFloat = 6
    static let iconLeft:CGFloat = 60
    static let fieldFont:CGFloat = 26
    static let fieldWidth:CGFloat = 200
    static let fieldHeight:CGFloat = 40
}
