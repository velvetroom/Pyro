import XCTest
@testable import Pyro

class TestMetricsBuilder_Max:XCTestCase {
    private var builder:MetricsBuilder!
    
    override func setUp() {
        super.setUp()
        self.builder = MetricsBuilder()
    }
    
    func testMakesMaxValues() {
        var itemA:ScraperItem = ScraperItem()
        itemA.date = "2001-09-09"
        itemA.year = 1880
        itemA.month = 1
        itemA.count = 5
        var itemB:ScraperItem = ScraperItem()
        itemB.date = "2001-09-09"
        itemB.year = 1880
        itemB.month = 1
        itemB.count = 99
        var itemC:ScraperItem = ScraperItem()
        itemC.date = "2001-09-09"
        itemC.year = 2880
        itemC.month = 1
        itemC.count = 67
        var itemD:ScraperItem = ScraperItem()
        itemD.date = "2001-09-09"
        itemD.year = 2880
        itemD.month = 1
        itemD.count = 77
        var itemE:ScraperItem = ScraperItem()
        itemE.date = "2001-09-09"
        itemE.year = 2880
        itemE.month = 2
        itemE.count = 33
        var itemF:ScraperItem = ScraperItem()
        itemF.date = "2001-09-09"
        itemF.year = 3880
        itemF.month = 1
        itemF.count = 44
        let stats:Metrics = self.builder.build(items:[itemA, itemB, itemC, itemD, itemE, itemF])
        XCTAssertEqual(stats.contributions.years.count, 3, "Invalid years")
        if stats.contributions.years.count == 3 {
            XCTAssertEqual(stats.contributions.years[0].months.count, 1, "Invalid months")
            XCTAssertEqual(stats.contributions.years[1].months.count, 2, "Invalid months")
            XCTAssertEqual(stats.contributions.years[2].months.count, 1, "Invalid months")
            if stats.contributions.years[0].months.count == 1 &&
                stats.contributions.years[1].months.count == 2 &&
                stats.contributions.years[2].months.count == 1 {
                XCTAssertEqual(stats.contributions.max.day, 99, "Invalid max")
                XCTAssertEqual(stats.contributions.max.month, 144, "Invalid max")
                XCTAssertEqual(stats.contributions.max.year, 177, "Invalid max")
            }
        }
    }
    
    func testMaxStreakNotRepeat() {
        var itemA:ScraperItem = ScraperItem()
        itemA.count = 1
        itemA.date = "2000-01-01"
        var itemB:ScraperItem = ScraperItem()
        itemB.count = 3
        itemB.date = "2000-01-02"
        var itemC:ScraperItem = ScraperItem()
        itemC.count = 1
        itemC.date = "2000-01-01"
        let statsA:Metrics = self.builder.build(items:[itemA, itemB])
        let statsB:Metrics = self.builder.build(items:[itemC])
        XCTAssertEqual(statsA.streak.max, 2, "Invalid streak")
        XCTAssertEqual(statsB.streak.max, 1, "Invalid streak")
    }
}
