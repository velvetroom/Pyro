import Foundation
import CleanArchitecture

struct StatsYearsViewModel:ViewModelProtocol {
    var items:[Year]
    
    init() {
        self.items = []
    }
}
