import Foundation
import CleanArchitecture

struct StatsContentViewModel:ViewModelProtocol {
    var items:[StatsItem]
    var streak:NSAttributedString
    var contributions:NSAttributedString
    
    init() {
        self.items = []
        self.streak = NSAttributedString()
        self.contributions = NSAttributedString()
    }
}
