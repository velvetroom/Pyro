import Foundation

protocol StatsStateProtocol {
    func makeViewModel(factory:StatsFactory) -> StatsStateViewModel
}
