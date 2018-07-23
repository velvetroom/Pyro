import Foundation

class StatsStateNeedsSync:StatsStateProtocol {
    func makeViewModel(factory:StatsFactory) -> StatsStateViewModel {
        return factory.make(state:self)
    }
}
