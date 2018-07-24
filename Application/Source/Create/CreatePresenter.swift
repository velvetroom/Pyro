import Foundation
import CleanArchitecture

class CreatePresenter:PresenterProtocol {
    var interactor:CreateInteractor!
    var viewModel:ViewModel!
    
    required init() { }
    
    func validate(url:String) {
        
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
}
