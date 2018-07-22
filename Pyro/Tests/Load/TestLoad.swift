import XCTest
@testable import Pyro

class TestLoad:XCTestCase {
    private var load:Load!
    private var delegate:MockLoadDelegate!
    private var request:MockRequestProtocol!
    private var scraper:MockScraperProtocol!

    override func setUp() {
        super.setUp()
        self.load = Load()
        self.delegate = MockLoadDelegate()
        self.request = MockRequestProtocol()
        self.scraper = MockScraperProtocol()
        self.load.delegate = self.delegate
        self.load.request = self.request
        self.load.scraper = self.scraper
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
    
    func testReleasesScraperOnSuccess() {
        XCTAssertNotNil(self.load.scraper, "Should initially be not nil")
        self.request.data = Data()
        self.load.start(user:User())
        XCTAssertNil(self.load.scraper, "Should finally be nil")
    }
    
    func testReleasesErrorOnSuccess() {
        XCTAssertNotNil(self.load.scraper, "Should initially be not nil")
        self.request.error = RequestError.emptyResponse
        self.load.start(user:User())
        XCTAssertNil(self.load.scraper, "Should finally be nil")
    }
    
    func testRequestAllYears() {
        let receiveStartingYear:XCTestExpectation = self.expectation(description:"Starting year missing")
        let receiveEndingYear:XCTestExpectation = self.expectation(description:"Ending year missing")
        self.request.data = Data()
        self.request.onReceived = { (year:Int) in
            if year == 2007 {
                receiveStartingYear.fulfill()
            } else if year == 2020 {
                receiveEndingYear.fulfill()
            }
        }
        self.load.start(user:User())
        self.waitForExpectations(timeout:0.3, handler:nil)
    }
    
    func testScrapsItems() {
        var expect:XCTestExpectation? = self.expectation(description:"Items not cleaned")
        self.request.data = Data()
        self.scraper.onMakeItems = {
            expect?.fulfill()
            expect = nil
        }
        self.load.user = User()
        self.load.next(year:1990)
        self.waitForExpectations(timeout:0.1, handler:nil)
    }
    
    func testNotRetainingDelegate() {
        self.delegate = nil
        XCTAssertNil(self.load.delegate, "Retains delegate")
    }
    
    func testIfErrorStopRequestingFollowinYears() {
        let completed:XCTestExpectation = self.expectation(description:"Failed to complete")
        self.request.data = Data()
        var timesRequested:Int = 0
        self.request.onReceived = { (year:Int) in
            timesRequested += 1
        }
        self.scraper.error = ScraperError.dateInTheFuture
        self.delegate.onCompleted = { completed.fulfill() }
        self.load.user = User()
        self.load.next(year:1990)
        self.waitForExpectations(timeout:0.3, handler:nil)
        XCTAssertEqual(timesRequested, 1, "Requested more than expected")
    }
}
