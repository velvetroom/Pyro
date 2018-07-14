import XCTest
@testable import Pyro

class TestScraper:XCTestCase {
    private var scraper:Scraper!
    private var dataMin:Data!
    private var dataDuplicates:Data!
    private var dateFormatter:DateFormatter!
    private struct Constants {
        static let expectedDaysMin:Int = 17
        static let expectedDaysDuplicates:Int = 2
        static let firstCount:Int = 16
        static let firstDate:String = "2018-06-24"
        static let lastCount:Int = 9
        static let lastDate:String = "2018-07-10"
    }
    
    override func setUp() {
        super.setUp()
        self.scraper = Scraper()
        self.dateFormatter = DateFormatter()
        self.dateFormatter.dateFormat = StatsConstants.dateFormat
        let urlMin:URL = Bundle(for:type(of:self)).url(forResource:"StatsMin", withExtension:"stub")!
        let urlDuplicates:URL = Bundle(for:type(of:self)).url(forResource:"StatsDuplicates", withExtension:"stub")!
        do { try self.dataMin = Data(contentsOf:urlMin) } catch { }
        do { try self.dataDuplicates = Data(contentsOf:urlDuplicates) } catch { }
    }
    
    func testReturnsAnItemPerDay() {
        self.scraper.makeItems(data:self.dataMin)
        XCTAssertEqual(self.scraper.items.count, Constants.expectedDaysMin, "Not all days scrapped")
        XCTAssertEqual(Constants.firstCount, self.scraper.items.first?.count, "Invalid count")
        XCTAssertEqual(Constants.firstDate, self.scraper.items.first?.date, "Invalid date")
        XCTAssertEqual(Constants.lastCount, self.scraper.items.last?.count, "Invalid count")
        XCTAssertEqual(Constants.lastDate, self.scraper.items.last?.date, "Invalid date")
    }
    
    func testItemsOrderedByDate() {
        self.scraper.makeItems(data:self.dataMin)
        var previousDate:Date?
        for item:ScraperItem in self.scraper.items {
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
    
    func testAvoidsDuplicates() {
        self.scraper.makeItems(data:self.dataDuplicates)
        XCTAssertEqual(self.scraper.items.count, Constants.expectedDaysDuplicates, "Not removing duplicates")
    }
    
    func testAddItemsFromDifferentYears() {
        self.scraper.makeItems(data:self.dataMin)
        self.scraper.makeItems(data:self.dataDuplicates)
        XCTAssertEqual(self.scraper.items.count, Constants.expectedDaysDuplicates + Constants.expectedDaysMin,
                       "Not appending items")
    }
}
