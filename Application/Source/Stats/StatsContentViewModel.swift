import Foundation
import CleanArchitecture

struct StatsContentViewModel:ViewModelProtocol {
    var streak:NSAttributedString
    var contributions:NSAttributedString
    var actionsEnabled:Bool
    
    init() {
        self.streak = NSAttributedString()
        self.contributions = NSAttributedString()
        self.actionsEnabled = false
    }
}
