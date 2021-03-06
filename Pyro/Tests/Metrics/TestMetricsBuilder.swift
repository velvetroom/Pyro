import XCTest
@testable import Pyro

class TestMetricsBuilder:XCTestCase {
    private var builder:MetricsBuilder!
    
    override func setUp() {
        super.setUp()
        self.builder = MetricsBuilder()
    }
    
    func testMakesFirstContribution() {
        var itemA:ScraperItem = ScraperItem()
        itemA.date = "2001-09-09"
        var itemB:ScraperItem = ScraperItem()
        itemB.date = "2001-10-08"
        itemB.count = 1
        var itemC:ScraperItem = ScraperItem()
        itemC.date = "2001-11-07"
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = MetricsConstants.dateFormat
        let expectedDate:Date = dateFormatter.date(from:itemB.date)!
        let stats:Metrics = self.builder.build(items:[itemA, itemB, itemC])
        XCTAssertEqual(stats.contributions.first, expectedDate, "Invalid stats")
    }
    
    func testMakesLastContribution() {
        var itemA:ScraperItem = ScraperItem()
        itemA.date = "2001-09-09"
        var itemB:ScraperItem = ScraperItem()
        itemB.date = "2001-10-08"
        itemB.count = 1
        var itemC:ScraperItem = ScraperItem()
        itemC.date = "2001-11-07"
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = MetricsConstants.dateFormat
        let expectedDate:Date = dateFormatter.date(from:itemB.date)!
        let stats:Metrics = self.builder.build(items:[itemA, itemB, itemC])
        XCTAssertEqual(stats.contributions.last, expectedDate, "Invalid stats")
    }
    
    func testMakesContributions() {
        var itemA:ScraperItem = ScraperItem()
        itemA.count = 100
        itemA.date = "2000-01-01"
        var itemB:ScraperItem = ScraperItem()
        itemB.count = 10
        itemB.date = "2000-01-01"
        var itemC:ScraperItem = ScraperItem()
        itemC.count = 5
        itemC.date = "2000-01-01"
        let expectedCount:Int = itemA.count + itemB.count + itemC.count
        let stats:Metrics = self.builder.build(items:[itemA, itemB, itemC])
        XCTAssertEqual(stats.contributions.count, expectedCount, "Invalid stats")
    }
    
    func testMakesMaxStreak() {
        var itemA:ScraperItem = ScraperItem()
        itemA.count = 100
        itemA.date = "2000-01-01"
        var itemB:ScraperItem = ScraperItem()
        itemB.date = "2000-01-01"
        var itemC:ScraperItem = ScraperItem()
        itemC.count = 5
        itemC.date = "2000-01-01"
        var itemD:ScraperItem = ScraperItem()
        itemD.count = 1
        itemD.date = "2000-01-01"
        var itemE:ScraperItem = ScraperItem()
        itemE.count = 3
        itemE.date = "2000-01-01"
        var itemF:ScraperItem = ScraperItem()
        itemF.date = "2000-01-01"
        var itemG:ScraperItem = ScraperItem()
        itemG.count = 5345
        itemG.date = "2000-01-01"
        var itemH:ScraperItem = ScraperItem()
        itemH.count = 56
        itemH.date = "2000-01-01"
        let stats:Metrics = self.builder.build(items:[itemA, itemB, itemC, itemD, itemE, itemF, itemG, itemH])
        XCTAssertEqual(stats.streak.max, 3, "Invalid stats")
    }
    
    func testMakesCurrentStreak() {
        var itemA:ScraperItem = ScraperItem()
        itemA.count = 0
        itemA.date = "2000-01-01"
        var itemB:ScraperItem = ScraperItem()
        itemB.count = 10
        itemB.date = "2000-01-01"
        var itemC:ScraperItem = ScraperItem()
        itemC.count = 5
        itemC.date = "2000-01-01"
        let stats:Metrics = self.builder.build(items:[itemA, itemB, itemC])
        XCTAssertEqual(stats.streak.current, 2, "Invalid stats")
    }
    
    func testAddTimestamp() {
        let stats:Metrics = self.builder.build(items:[])
        XCTAssertNotNil(stats.timestamp, "Timestamp not added")
    }
}
