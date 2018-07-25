import Foundation
import CleanArchitecture

class CreatePresenter:Presenter {
    var interactor:CreateInteractor!
    var viewModels:ViewModels!
    
    required init() { }
    
    func validate(url:String) {
        var viewModel:CreateViewModel = CreateViewModel()
        viewModel.saveEnabled = false
        viewModel.loadingHidden = false
        self.viewModels.update(viewModel:viewModel)
        self.interactor.validate(url:url)
    }
    
    func save() {
        Application.router.popViewController(animated:true)
    }
    
    func cancel() {
        Application.router.popViewController(animated:true)
    }
    
    func didLoad() {
        self.viewModels.update(viewModel:CreateViewModel())
    }
    
    func shouldUpdate() {
        var viewModel:CreateViewModel = CreateViewModel()
        if let error:Error = self.interactor.error {
            viewModel.icon = #imageLiteral(resourceName: "assetInvalid.pdf")
            viewModel.message = error.localizedDescription
            viewModel.saveEnabled = false
        } else {
            viewModel.icon = #imageLiteral(resourceName: "assetValid.pdf")
            viewModel.saveEnabled = true
        }
        self.viewModels.update(viewModel:viewModel)
    }
}
