import UIKit

class ViewModelFactory {
    class func make(users:[User]) -> UsersViewModel {
        var viewModel:UsersViewModel = UsersViewModel()
        for user:User in users {
            viewModel.users.append(make(user:user))
        }
        return viewModel
    }
    
    private class func make(user:User) -> NSAttributedString {
        let string:NSMutableAttributedString = NSMutableAttributedString()
        let name:NSAttributedString = NSAttributedString(string:user.name, attributes:[NSAttributedStringKey.font:
            UIFont.systemFont(ofSize:UsersConstants.Cell.titleFontSize, weight:UIFont.Weight.bold)])
        let url:NSAttributedString = NSAttributedString(string:" @\(user.url)", attributes:[NSAttributedStringKey.font:
            UIFont.systemFont(ofSize:UsersConstants.Cell.subtitleFontSize, weight:UIFont.Weight.light)])
        string.append(name)
        string.append(url)
        return string
    }
    
    private init() { }
}
