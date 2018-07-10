import XCTest
@testable import Pyro

class TestScraper:XCTestCase {
    private var scraper:Scraper!
    private var data:Data!
    private var dateFormatter:DateFormatter!
    private struct Constants {
        static let expectedDays:Int = 17
        static let firstCount:Int = 16
        static let firstDate:String = "2018-06-24"
        static let lastCount:Int = 9
        static let lastDate:String = "2018-07-10"
        static let dateFormat:String = "yyyy-MM-dd"
    }
    
    override func setUp() {
        self.scraper = Scraper()
        self.dateFormatter = DateFormatter()
        self.dateFormatter.dateFormat = Constants.dateFormat
        let url:URL = Bundle(for:type(of:self)).url(forResource:"StatsMin", withExtension:"stub")!
        do { try self.data = Data(contentsOf:url) } catch { }
    }
    
    func testReturnsAndItemPerDay() {
        let items:[ScraperItem] = self.scraper.makeItems(data:self.data)
        XCTAssertEqual(items.count, Constants.expectedDays, "Not all days scrapped")
        XCTAssertEqual(Constants.firstCount, items.first?.count, "Invalid count")
        XCTAssertEqual(Constants.firstDate, items.first?.date, "Invalid date")
        XCTAssertEqual(Constants.lastCount, items.last?.count, "Invalid count")
        XCTAssertEqual(Constants.lastDate, items.last?.date, "Invalid date")
    }
    
    func testItemsOrderedByDate() {
        let items:[ScraperItem] = self.scraper.makeItems(data:self.data)
        var previousDate:Date?
        for item:ScraperItem in items {
            let date:Date? = self.dateFormatter.date(from:item.date)
            XCTAssertNotNil(date, "Invalid date")
            if let date:Date = date {
                if let previousDate:Date = previousDate {
                    XCTAssertGreaterThan(date, previousDate, "Unordered")
                }
            }
            previousDate = date
        }
    }
}
