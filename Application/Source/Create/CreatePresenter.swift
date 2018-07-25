import Foundation
import CleanArchitecture

class CreatePresenter:Presenter {
    var interactor:CreateInteractor!
    var viewModels:ViewModels!
    
    required init() { }
    
    func validate(url:String) {
        self.updateLoading()
        self.interactor.validate(url:url)
    }
    
    func save() {
//        self.interactor.router?.routeBack()
    }
    
    func cancel() {
//        self.interactor.router?.routeBack()
    }
    
    func didLoad() {
        self.viewModels.update(viewModel:CreateContentViewModel())
    }
    
    func shouldUpdate() {
        if let error:Error = self.interactor.error {
            self.update(error:error)
        } else {
            self.updateSuccess()
        }
    }
    
    private func updateLoading() {
        var viewModel:CreateContentViewModel = CreateContentViewModel()
        viewModel.saveEnabled = false
        viewModel.loadingHidden = false
        self.viewModels.update(viewModel:viewModel)
    }
    
    private func update(error:Error) {
        var viewModel:CreateContentViewModel = CreateContentViewModel()
        viewModel.icon = #imageLiteral(resourceName: "assetInvalid.pdf")
        viewModel.message = error.localizedDescription
        viewModel.saveEnabled = false
        self.viewModels.update(viewModel:viewModel)
    }
    
    private func updateSuccess() {
        var viewModel:CreateContentViewModel = CreateContentViewModel()
        viewModel.icon = #imageLiteral(resourceName: "assetValid.pdf")
        viewModel.saveEnabled = true
        self.viewModels.update(viewModel:viewModel)
    }
}
