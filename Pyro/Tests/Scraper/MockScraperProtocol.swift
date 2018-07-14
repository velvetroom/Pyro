import Foundation
@testable import Pyro

class MockScraperProtocol:ScraperProtocol {
    var onMakeItems:(() -> Void)?
    var items:[ScraperItem]
    
    init() {
        self.items = []
    }
    
    func makeItems(data:Data) {
        self.onMakeItems?()
    }
}
