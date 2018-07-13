import Foundation
@testable import Pyro

class MockScraperCleanerProtocol:ScraperCleanerProtocol {
    var onClean:(() -> Void)?
    
    func clean(year:Int, items:[ScraperItem]) -> [ScraperItem] {
        self.onClean?()
        return []
    }
}
