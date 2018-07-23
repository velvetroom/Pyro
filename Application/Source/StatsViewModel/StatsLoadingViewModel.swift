import Foundation
import CleanArchitecture

struct StatsLoadingViewModel:ViewModelProtocol {
    var progress:Float
    
    init() {
        self.progress = 0
    }
}
