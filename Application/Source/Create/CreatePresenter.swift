import Foundation
import CleanArchitecture

class CreatePresenter:PresenterProtocol {
    var interactor:CreateInteractor!
    var viewModel:ViewModel!
    
    required init() { }
    
    func validate(url:String) {
        self.updateLoading()
        self.interactor.validate(url:url)
    }
    
    func save() {
        self.interactor.router?.routeBack()
    }
    
    func cancel() {
        self.interactor.router?.routeBack()
    }
    
    func didLoad() {
        self.viewModel.update(property:CreateContentViewModel())
    }
    
    func shouldUpdate() {
        if let error:Error = self.interactor.error {
            self.update(error:error)
        } else {
            self.updateSuccess()
        }
    }
    
    private func updateLoading() {
        var property:CreateContentViewModel = CreateContentViewModel()
        property.saveEnabled = false
        property.loadingHidden = false
        self.viewModel.update(property:property)
    }
    
    private func update(error:Error) {
        var property:CreateContentViewModel = CreateContentViewModel()
        property.icon = #imageLiteral(resourceName: "assetInvalid.pdf")
        property.message = error.localizedDescription
        property.saveEnabled = false
        self.viewModel.update(property:property)
    }
    
    private func updateSuccess() {
        var property:CreateContentViewModel = CreateContentViewModel()
        property.icon = #imageLiteral(resourceName: "assetValid.pdf")
        property.saveEnabled = true
        self.viewModel.update(property:property)
    }
}
