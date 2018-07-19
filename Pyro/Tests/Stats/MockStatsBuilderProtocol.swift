import Foundation
@testable import Pyro

class MockStatsBuilderProtocol:MetricsBuilderProtocol {
    var onBuild:(() -> Void)?
    
    func build(items:[ScraperItem]) -> Metrics {
        self.onBuild?()
        return Metrics()
    }
}
