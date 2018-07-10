import XCTest
@testable import Pyro

class TestStatsBuilder:XCTestCase {
    private var builder:StatsBuilder!
    
    override func setUp() {
        super.setUp()
        self.builder = StatsBuilder()
    }
    
    func testMakesFirstContribution() {
        var itemA:ScraperItem = ScraperItem()
        itemA.date = "2001-09-09"
        var itemB:ScraperItem = ScraperItem()
        itemB.date = "2001-10-08"
        var itemC:ScraperItem = ScraperItem()
        itemC.date = "2001-11-07"
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = StatsConstants.dateFormat
        let expectedDate:Date = dateFormatter.date(from:itemA.date)!
        self.builder.items = [itemA, itemB, itemC]
        self.builder.build()
        XCTAssertEqual(self.builder.stats.firstContribution, expectedDate, "Invalid stats")
    }
    
    func testMakesLastContribution() {
        var itemA:ScraperItem = ScraperItem()
        itemA.date = "2001-09-09"
        var itemB:ScraperItem = ScraperItem()
        itemB.date = "2001-10-08"
        var itemC:ScraperItem = ScraperItem()
        itemC.date = "2001-11-07"
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = StatsConstants.dateFormat
        let expectedDate:Date = dateFormatter.date(from:itemC.date)!
        self.builder.items = [itemA, itemB, itemC]
        self.builder.build()
        XCTAssertEqual(self.builder.stats.lastContribution, expectedDate, "Invalid stats")
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
        self.builder.items = [itemA, itemB, itemC]
        self.builder.build()
        XCTAssertEqual(self.builder.stats.contributions, expectedCount, "Invalid stats")
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
        self.builder.items = [itemA, itemB, itemC, itemD, itemE, itemF, itemG, itemH]
        self.builder.build()
        XCTAssertEqual(self.builder.stats.maxStreak, 3, "Invalid stats")
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
        self.builder.items = [itemA, itemB, itemC]
        self.builder.build()
        XCTAssertEqual(self.builder.stats.currentStreak, 2, "Invalid stats")
    }
}
