import Foundation

class StatsStateError:StatsStateProtocol {
    let error:Error
    
    init(error:Error) {
        self.error = error
    }
    
    func makeViewModel(factory:StatsFactory) -> StatsStateViewModel {
        return factory.make(state:self)
    }
}
