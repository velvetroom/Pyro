import XCTest
@testable import Pyro

class TestMetricsBuilder_Years:XCTestCase {
    private var builder:MetricsBuilder!
    
    override func setUp() {
        super.setUp()
        self.builder = MetricsBuilder()
    }
    
    func testMakesYearItemPerYear() {
        var itemA:ScraperItem = ScraperItem()
        itemA.date = "2001-01-01"
        var itemB:ScraperItem = ScraperItem()
        itemB.date = "2001-01-02"
        var itemC:ScraperItem = ScraperItem()
        itemC.date = "2002-01-01"
        let stats:Metrics = self.builder.build(items:[itemA, itemB, itemC])
        XCTAssertEqual(stats.contributions.years.count, 2, "Invalid years")    
    }
}
