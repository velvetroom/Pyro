import UIKit
import Pyro

class UsersFactory {
    private let numberFormatter:NumberFormatter
    
    init() {
        self.numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
    }
    
    func byName(pyro:Pyro) -> UsersViewModel {
        var viewModel:UsersViewModel = UsersViewModel()
        for user:User in pyro.users {
            var item:UsersItem = UsersItem()
            item.name = self.makeName(user:user)
            item.user = user
            viewModel.users.append(item)
        }
        return viewModel
    }
    
    func byContributions(pyro:Pyro) -> UsersViewModel {
        var viewModel:UsersViewModel = UsersViewModel()
        for user:User in self.usersByContributions(pyro:pyro) {
            var item:UsersItem = UsersItem()
            item.name = self.makeName(user:user)
            item.user = user
            if user.stats.timestamp != nil {
                item.value = self.makeValue(value:user.stats.contributions.count)
            }
            viewModel.users.append(item)
        }
        return viewModel
    }
    
    func byStreak(pyro:Pyro) -> UsersViewModel {
        var viewModel:UsersViewModel = UsersViewModel()
        for user:User in self.usersByStreak(pyro:pyro) {
            var item:UsersItem = UsersItem()
            item.name = self.makeName(user:user)
            item.user = user
            if user.stats.timestamp != nil {
                item.value = self.makeValue(value:user.stats.streak.max)
            }
            viewModel.users.append(item)
        }
        return viewModel
    }
    
    private func makeName(user:User) -> NSAttributedString {
        let string:NSMutableAttributedString = NSMutableAttributedString()
        let name:NSAttributedString = NSAttributedString(string:user.name, attributes:[NSAttributedString.Key.font:
            UIFont.systemFont(ofSize:Constants.titleFontSize, weight:UIFont.Weight.regular)])
        let url:NSAttributedString = NSAttributedString(string:"\n\(user.url)",
            attributes:[NSAttributedString.Key.font:UIFont.systemFont(ofSize:Constants.subtitleFontSize,
                                                                      weight:UIFont.Weight.ultraLight)])
        string.append(name)
        string.append(url)
        return string
    }
    
    private func usersByContributions(pyro:Pyro) -> [User] {
        return pyro.users.sorted { (userA:User, userB:User) -> Bool in
            if userA.stats.timestamp == nil {
                return false
            } else if userB.stats.timestamp == nil {
                return true
            } else {
                return userA.stats.contributions.count > userB.stats.contributions.count
            }
        }
    }
    
    private func usersByStreak(pyro:Pyro) -> [User] {
        return pyro.users.sorted { (userA:User, userB:User) -> Bool in
            if userA.stats.timestamp == nil {
                return false
            } else if userB.stats.timestamp == nil {
                return true
            } else {
                return userA.stats.streak.max > userB.stats.streak.max
            }
        }
    }
    
    private func makeValue(value:Int) -> NSAttributedString {
        let stringValue:String = self.numberFormatter.string(from:NSNumber(value:value))!
        let string:NSAttributedString = NSAttributedString(string:stringValue, attributes:
            [NSAttributedString.Key.font:
                UIFont.systemFont(ofSize:Constants.valueFontSize, weight:UIFont.Weight.ultraLight)])
        return string
    }
}

private struct Constants {
    static let titleFontSize:CGFloat = 16
    static let subtitleFontSize:CGFloat = 12
    static let valueFontSize:CGFloat = 13
}
