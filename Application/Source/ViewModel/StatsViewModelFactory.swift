import Foundation
import Pyro

class StatsViewModelFactory {
    class func make(user:User) -> StatsViewModel {
        var viewModel:StatsViewModel = StatsViewModel()
        viewModel.items = makeItems(user:user)
        return viewModel
    }
    
    private class func makeItems(user:User) -> [StatsViewModelItem] {
        return []
    }
    
    private init() { }
}
