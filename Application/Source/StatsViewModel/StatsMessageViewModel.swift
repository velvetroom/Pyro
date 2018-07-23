import Foundation
import CleanArchitecture

struct StatsMessageViewModel:ViewModelProtocol {
    var message:String
    
    init() {
        self.message = String()
    }
}
