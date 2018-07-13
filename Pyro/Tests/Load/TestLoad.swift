import XCTest
@testable import Pyro

class TestLoad:XCTestCase {
    private var load:Load!
    private var delegate:MockLoadDelegate!
    private var request:MockRequestProtocol!
    private var scraper:MockScraperProtocol!
    private var cleaner:MockScraperCleanerProtocol!

    override func setUp() {
        super.setUp()
        self.load = Load()
        self.delegate = MockLoadDelegate()
        self.request = MockRequestProtocol()
        self.scraper = MockScraperProtocol()
        self.cleaner = MockScraperCleanerProtocol()
        self.load.delegate = self.delegate
        self.load.request = self.request
        self.load.scraper = self.scraper
        self.load.cleaner = self.cleaner
    }

    func testSendsLoadedItemsToDelegate() {
        var received:Bool = false
        self.request.data = Data()
        self.delegate.onCompleted = { received = true }
        self.load.start(user:User())
        XCTAssertTrue(received, "Not received")
    }
    
    func testSendsErrorToDelegate() {
        var received:Bool = false
        self.request.error = RequestError.emptyResponse
        self.delegate.onError = { received = true }
        self.load.start(user:User())
        XCTAssertTrue(received, "Not received")
    }
    
    func testRequestAllYears() {
        let receiveStartingYear:XCTestExpectation = self.expectation(description:"Starting year missing")
        let receiveEndingYear:XCTestExpectation = self.expectation(description:"Ending year missing")
        self.request.data = Data()
        self.request.onReceived = { (year:Int) in
            if year == LoadConstants.startingYear {
                receiveStartingYear.fulfill()
            } else if year == LoadConstants.endingYear {
                receiveEndingYear.fulfill()
            }
        }
        self.load.start(user:User())
        self.waitForExpectations(timeout:0.3, handler:nil)
    }
    
    func testCleansItems() {
        var expect:XCTestExpectation? = self.expectation(description:"Items not cleaned")
        self.request.data = Data()
        self.cleaner.onClean = {
            expect?.fulfill()
            expect = nil
        }
        self.load.start(user:User())
        self.waitForExpectations(timeout:0.1, handler:nil)
    }
    
    func testRemovesPreviousItemsBeforeStarting() {
        self.load.items = [ScraperItem()]
        self.load.start(user:User())
        XCTAssertTrue(self.load.items.isEmpty, "Not removed")
    }
    
    func testScrapsItems() {
        var expect:XCTestExpectation? = self.expectation(description:"Items not cleaned")
        self.request.data = Data()
        self.scraper.onMakeItems = {
            expect?.fulfill()
            expect = nil
        }
        self.load.start(user:User())
        self.waitForExpectations(timeout:0.1, handler:nil)
    }
    
    func testNotRetainingDelegate() {
        self.delegate = nil
        XCTAssertNil(self.load.delegate, "Retains delegate")
    }
}
