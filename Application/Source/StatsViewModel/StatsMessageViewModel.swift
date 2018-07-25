import Foundation
import CleanArchitecture

struct StatsMessageViewModel:ViewModel {
    var message:String
    
    init() {
        self.message = String()
    }
}
