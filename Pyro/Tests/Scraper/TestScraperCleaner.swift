import XCTest
@testable import Pyro

class TestScraperCleaner:XCTestCase {
    private var cleaner:ScraperCleaner!
    
    override func setUp() {
        self.cleaner = ScraperCleaner()
    }
    
    func testCleansFromDifferentYear() {
        var itemA:ScraperItem = ScraperItem()
        itemA.date = "2015-01-01"
        var itemB:ScraperItem = ScraperItem()
        itemB.date = "2013-10-11"
        var itemC:ScraperItem = ScraperItem()
        itemC.date = "2015-08-13"
        var itemD:ScraperItem = ScraperItem()
        itemD.date = "2016-05-12"
        let items:[ScraperItem] = self.cleaner.clean(year:2015, items:[itemA, itemB, itemC, itemD])
        XCTAssertEqual(items.count, 2, "Failed to clean")
    }
}
