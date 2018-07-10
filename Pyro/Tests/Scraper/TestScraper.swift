import XCTest
@testable import Pyro

class TestScraper:XCTestCase {
    private var scraper:Scraper!
    private var data:Data!
    
    override func setUp() {
        self.scraper = Scraper()
        let url:URL = Bundle(for:type(of:self)).url(forResource:"StatsMin", withExtension:"stub")!
        do { try self.data = Data(contentsOf:url) } catch { }
    }
    
    func testReturnsItems() {
//        let items:[ScraperItem] = self.scraper.make(items:self.data)
    }
}
