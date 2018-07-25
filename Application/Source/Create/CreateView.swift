import UIKit
import CleanArchitecture

class CreateView:View<CreatePresenter>, UITextFieldDelegate {
    override func viewDidLoad() {
        self.configureView()
        self.configureViewModel()
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated:Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setToolbarHidden(true, animated:false)
    }
    
    override func viewDidAppear(_ animated:Bool) {
        super.viewDidAppear(animated)
//        self.content.field.becomeFirstResponder()
    }
    
    func textField(_:UITextField, shouldChangeCharactersIn range:NSRange, replacementString string:String) -> Bool {
//        let current:String = self.content.field.text!
//        self.presenter.validate(url:current.replacingCharacters(in:Range(range, in:current)!, with:string))
        return true
    }
    
    func textFieldShouldReturn(_:UITextField) -> Bool {
//        self.content.field.resignFirstResponder()
        return true
    }

    private func configureView() {
        self.title = NSLocalizedString("CreateView_Title", comment:String())
//        self.content.field.delegate = self
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem:UIBarButtonItem.SystemItem.cancel,
                                                                 target:self, action:#selector(self.selectorCancel))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem:UIBarButtonItem.SystemItem.save,
                                                                target:self, action:#selector(self.selectorSave))
        if #available(iOS 11.0, *) {
            self.navigationItem.largeTitleDisplayMode = UINavigationItem.LargeTitleDisplayMode.always
        }
    }
    
    private func configureViewModel() {
//        self.presenter.viewModel.observe { [weak self] (property:CreateContentViewModel) in
//            self?.navigationItem.rightBarButtonItem?.isEnabled = property.saveEnabled
//            self?.content.message.text = property.message
//            self?.content.icon.image = property.icon
//            self?.content.loading.isHidden = property.loadingHidden
//        }
    }
    
    @objc private func selectorSave() {
//        self.content.field.resignFirstResponder()
        self.presenter.save()
    }
    
    @objc private func selectorCancel() {
//        self.content.field.resignFirstResponder()
        self.presenter.cancel()
    }
}
