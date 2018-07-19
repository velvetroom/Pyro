import UIKit
import Pyro

class UsersFactory {
    private let numberFormatter:NumberFormatter
    private var unknown:NSAttributedString!
    
    init() {
        self.numberFormatter = NumberFormatter()
        self.unknown = self.makeUnknown()
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
            if let metrics:Metrics = user.metrics {
                item.value = self.makeValue(value:metrics.contributions.count)
            } else {
                item.value = self.unknown
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
            if let metrics:Metrics = user.metrics {
                item.value = self.makeValue(value:metrics.streak.max)
            } else {
                item.value = self.unknown
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
            if let metricsA:Metrics = userA.metrics {
                if let metricsB:Metrics = userB.metrics {
                    return metricsA.contributions.count > metricsB.contributions.count
                } else {
                    return true
                }
            } else {
                return false
            }
        }
    }
    
    private func usersByStreak(pyro:Pyro) -> [User] {
        return pyro.users.sorted { (userA:User, userB:User) -> Bool in
            if let metricsA:Metrics = userA.metrics {
                if let metricsB:Metrics = userB.metrics {
                    return metricsA.streak.max > metricsB.streak.max
                } else {
                    return true
                }
            } else {
                return false
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
    
    private func makeUnknown() -> NSAttributedString {
        let string:NSAttributedString = NSAttributedString(string:
            NSLocalizedString("UsersFactory_Unknown", comment:String()), attributes:
            [NSAttributedString.Key.font :
                UIFont.systemFont(ofSize:Constants.valueFontSize, weight:UIFont.Weight.ultraLight),
             NSAttributedString.Key.foregroundColor : UIColor(white:0, alpha:0.4)])
        return string
    }
}

private struct Constants {
    static let titleFontSize:CGFloat = 16
    static let subtitleFontSize:CGFloat = 12
    static let valueFontSize:CGFloat = 13
    static let unknownFontSize:CGFloat = 10
}
