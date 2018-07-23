import Foundation
import Pyro

class StatsStateReady:StatsStateProtocol {
    let metrics:Metrics
    
    init(metrics:Metrics) {
        self.metrics = metrics
    }
    
    func makeViewModel(factory:StatsFactory) -> StatsStateViewModel {
        return factory.make(state:self)
    }
}
