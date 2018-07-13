import Foundation
@testable import Pyro

class MockStatsBuilderProtocol:StatsBuilderProtocol {
    var onBuild:(() -> Void)?
    
    func build(items:[ScraperItem]) -> Stats {
        self.onBuild?()
        return Stats()
    }
}
