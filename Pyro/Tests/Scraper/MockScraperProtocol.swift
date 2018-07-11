import Foundation
@testable import Pyro

class MockScraperProtocol:ScraperProtocol {
    var onMakeItems:(() -> Void)?
    func makeItems(data:Data) -> [ScraperItem] {
        self.onMakeItems?()
        return []
    }
}
