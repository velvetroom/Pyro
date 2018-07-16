import UIKit
import Pyro

class UsersViewModelFactory {
    func orderedByName(pyro:Pyro) -> UsersViewModel {
        var viewModel:UsersViewModel = UsersViewModel()
        for user:User in pyro.users {
            var item:UsersViewModelItem = UsersViewModelItem()
            item.name = self.makeName(user:user)
            viewModel.users.append(item)
        }
        return viewModel
    }
    
    private func makeName(user:User) -> NSAttributedString {
        let string:NSMutableAttributedString = NSMutableAttributedString()
        let name:NSAttributedString = NSAttributedString(string:user.name, attributes:[NSAttributedString.Key.font:
            UIFont.systemFont(ofSize:Constants.titleFontSize, weight:UIFont.Weight.bold)])
        let url:NSAttributedString = NSAttributedString(string:"\n\(user.url)", attributes:[NSAttributedString.Key.font:
            UIFont.systemFont(ofSize:Constants.subtitleFontSize, weight:UIFont.Weight.light)])
        string.append(name)
        string.append(url)
        return string
    }
}

private struct Constants {
    static let titleFontSize:CGFloat = 15
    static let subtitleFontSize:CGFloat = 13
}
