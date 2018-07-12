import UIKit
import Pyro

class UsersViewModelFactory {
    func make(pyro:PyroProtocol) -> UsersViewModel {
        var viewModel:UsersViewModel = UsersViewModel()
        for user:User in pyro.users {
            viewModel.users.append(make(user:user))
        }
        return viewModel
    }
    
    private func make(user:User) -> NSAttributedString {
        let string:NSMutableAttributedString = NSMutableAttributedString()
        let name:NSAttributedString = NSAttributedString(string:user.name, attributes:[NSAttributedString.Key.font:
            UIFont.systemFont(ofSize:UsersConstants.Cell.titleFontSize, weight:UIFont.Weight.bold)])
        let url:NSAttributedString = NSAttributedString(string:" @\(user.url)", attributes:[NSAttributedString.Key.font:
            UIFont.systemFont(ofSize:UsersConstants.Cell.subtitleFontSize, weight:UIFont.Weight.light)])
        string.append(name)
        string.append(url)
        return string
    }
}
