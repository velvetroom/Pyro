import Foundation
import CleanArchitecture

struct StatsLoadingViewModel:ViewModel {
    var progress:Float
    
    init() {
        self.progress = 0
    }
}
