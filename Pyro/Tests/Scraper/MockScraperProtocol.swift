import Foundation
@testable import Pyro

class MockScraperProtocol:ScraperProtocol {
    var onMakeItems:(() -> Void)?
    var items:[ScraperItem]
    var error:Error?
    
    init() {
        self.items = []
    }
    
    func makeItems(data:Data) throws {
        self.onMakeItems?()
        if let error:Error = self.error {
            throw error
        }
    }
}
