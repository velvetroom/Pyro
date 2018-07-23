import Foundation

class StatsStateLoading:StatsStateProtocol {
    let progress:Float
    
    init(progress:Float) {
        self.progress = progress
    }
    
    func makeViewModel(factory:StatsFactory) -> StatsStateViewModel {
        return factory.make(state:self)
    }
}
