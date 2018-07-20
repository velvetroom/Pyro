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
        itemA.date = "2001-09-09"
        itemA.year = 1880
        itemA.count = 90
        var itemB:ScraperItem = ScraperItem()
        itemB.date = "2001-09-09"
        itemB.year = 1880
        itemB.count = 56
        var itemC:ScraperItem = ScraperItem()
        itemC.date = "2001-09-09"
        itemC.year = 2880
        itemC.count = 35
        let stats:Metrics = self.builder.build(items:[itemA, itemB, itemC])
        XCTAssertEqual(stats.contributions.years.count, 2, "Invalid years")
        if stats.contributions.years.count == 2 {
            XCTAssertEqual(stats.contributions.years[0].value, itemA.year, "Invalid year")
            XCTAssertEqual(stats.contributions.years[1].value, itemC.year, "Invalid year")
            XCTAssertEqual(stats.contributions.years[0].contributions, itemA.count + itemB.count, "Invalid count")
            XCTAssertEqual(stats.contributions.years[1].contributions, itemC.count, "Invalid count")
        }
    }
    
    func testMakesMonthsItemPerMonth() {
        var itemA:ScraperItem = ScraperItem()
        itemA.date = "2001-09-09"
        itemA.year = 1880
        itemA.month = 1
        itemA.count = 34
        var itemB:ScraperItem = ScraperItem()
        itemB.date = "2001-09-09"
        itemB.year = 1880
        itemB.month = 1
        itemB.count = 23
        var itemC:ScraperItem = ScraperItem()
        itemC.date = "2001-09-09"
        itemC.year = 2880
        itemC.month = 1
        itemC.count = 67
        var itemD:ScraperItem = ScraperItem()
        itemD.date = "2001-09-09"
        itemD.year = 2880
        itemD.month = 2
        itemD.count = 22
        var itemE:ScraperItem = ScraperItem()
        itemE.date = "2001-09-09"
        itemE.year = 3880
        itemE.month = 1
        itemE.count = 99
        let stats:Metrics = self.builder.build(items:[itemA, itemB, itemC, itemD, itemE])
        XCTAssertEqual(stats.contributions.years.count, 3, "Invalid years")
        if stats.contributions.years.count == 3 {
            XCTAssertEqual(stats.contributions.years[0].months.count, 1, "Invalid months")
            XCTAssertEqual(stats.contributions.years[1].months.count, 2, "Invalid months")
            XCTAssertEqual(stats.contributions.years[2].months.count, 1, "Invalid months")
            if stats.contributions.years[0].months.count == 1 &&
                stats.contributions.years[1].months.count == 2 &&
                stats.contributions.years[2].months.count == 1 {
                XCTAssertEqual(stats.contributions.years[0].months[0].value, itemA.month, "Invalid month")
                XCTAssertEqual(stats.contributions.years[1].months[0].value, itemC.month, "Invalid month")
                XCTAssertEqual(stats.contributions.years[1].months[1].value, itemD.month, "Invalid month")
                XCTAssertEqual(stats.contributions.years[2].months[0].value, itemE.month, "Invalid month")
                XCTAssertEqual(stats.contributions.years[0].months[0].contributions, itemA.count + itemB.count,
                               "Invalid count")
                XCTAssertEqual(stats.contributions.years[1].months[0].contributions, itemC.count, "Invalid count")
                XCTAssertEqual(stats.contributions.years[1].months[1].contributions, itemD.count, "Invalid count")
                XCTAssertEqual(stats.contributions.years[2].months[0].contributions, itemE.count, "Invalid count")
            }
        }
    }
}
