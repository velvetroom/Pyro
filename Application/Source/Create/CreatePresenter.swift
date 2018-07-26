import UIKit
import CleanArchitecture
import Pyro

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
        } else if let profile:Profile = self.interactor.profile {
            viewModel.icon = #imageLiteral(resourceName: "assetValid.pdf")
            viewModel.saveEnabled = true
            viewModel.user = profile.user
            viewModel.bio = self.bio(profile:profile)
        }
        self.viewModels.update(viewModel:viewModel)
    }
    
    private func bio(profile:Profile) -> NSAttributedString {
        let mutable:NSMutableAttributedString = NSMutableAttributedString()
        mutable.append(NSAttributedString(string:profile.name, attributes:
            [NSAttributedString.Key.font:UIFont.systemFont(ofSize:Constants.bioFont, weight:UIFont.Weight.bold)]))
        mutable.append(NSAttributedString(string:"\n\(profile.bio)", attributes:
            [NSAttributedString.Key.font:UIFont.systemFont(ofSize:Constants.bioFont, weight:UIFont.Weight.ultraLight)]))
        return mutable
    }
}

private struct Constants {
    static let bioFont:CGFloat = 16
}
