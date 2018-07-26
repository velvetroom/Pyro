import XCTest
@testable import Pyro

class TestLoad:XCTestCase {
    private var load:Load!
    private var delegate:MockLoadDelegate!
    private var scraper:MockScraperProtocol!

    override func setUp() {
        super.setUp()
        Configuration.requestType = MockRequestProtocol.self
        self.load = Load()
        self.delegate = MockLoadDelegate()
        self.scraper = MockScraperProtocol()
        self.load.delegate = self.delegate
        self.load.scraper = self.scraper
    }
    
    override func tearDown() {
        super.tearDown()
        MockRequestProtocol.data = nil
        MockRequestProtocol.error = nil
        MockRequestProtocol.onContributions = nil
        MockRequestProtocol.onValidate = nil
    }

    func testSendsLoadedItemsToDelegate() {
        var received:Bool = false
        MockRequestProtocol.data = Data()
        self.delegate.onCompleted = { received = true }
        self.load.start(user:UserFactory.make())
        XCTAssertTrue(received, "Not received")
    }
    
    func testSendsErrorToDelegate() {
        var received:Bool = false
        MockRequestProtocol.error = RequestError.emptyResponse
        self.delegate.onError = { received = true }
        self.load.start(user:UserFactory.make())
        XCTAssertTrue(received, "Not received")
    }
    
    func testReleasesScraperOnSuccess() {
        XCTAssertNotNil(self.load.scraper, "Should initially be not nil")
        MockRequestProtocol.data = Data()
        self.load.start(user:UserFactory.make())
        XCTAssertNil(self.load.scraper, "Should finally be nil")
    }
    
    func testReleasesErrorOnSuccess() {
        XCTAssertNotNil(self.load.scraper, "Should initially be not nil")
        MockRequestProtocol.error = RequestError.emptyResponse
        self.load.start(user:UserFactory.make())
        XCTAssertNil(self.load.scraper, "Should finally be nil")
    }
    
    func testRequestAllYears() {
        let receiveStartingYear:XCTestExpectation = self.expectation(description:"Starting year missing")
        let receiveEndingYear:XCTestExpectation = self.expectation(description:"Ending year missing")
        var expectProgress:XCTestExpectation? = self.expectation(description:"Progress not received")
        MockRequestProtocol.data = Data()
        self.delegate.onProgress = {
            expectProgress?.fulfill()
            expectProgress = nil
        }
        MockRequestProtocol.onContributions = { (year:Int) in
            if year == 2008 {
                receiveStartingYear.fulfill()
            } else if year == 2020 {
                receiveEndingYear.fulfill()
            }
        }
        self.load.start(user:UserFactory.make())
        self.waitForExpectations(timeout:0.3, handler:nil)
    }
    
    func testScrapsItems() {
        var expect:XCTestExpectation? = self.expectation(description:"Items not cleaned")
        MockRequestProtocol.data = Data()
        self.scraper.onMakeItems = {
            expect?.fulfill()
            expect = nil
        }
        self.load.user = UserFactory.make()
        self.load.next(year:1990)
        self.waitForExpectations(timeout:0.1, handler:nil)
    }
    
    func testNotRetainingDelegate() {
        self.delegate = nil
        XCTAssertNil(self.load.delegate, "Retains delegate")
    }
    
    func testIfErrorStopRequestingFollowinYears() {
        let completed:XCTestExpectation = self.expectation(description:"Failed to complete")
        MockRequestProtocol.data = Data()
        var timesRequested:Int = 0
        MockRequestProtocol.onContributions = { (year:Int) in
            timesRequested += 1
        }
        self.scraper.error = ScraperError.dateInTheFuture
        self.delegate.onCompleted = { completed.fulfill() }
        self.load.user = UserFactory.make()
        self.load.next(year:1990)
        self.waitForExpectations(timeout:0.3, handler:nil)
        XCTAssertEqual(timesRequested, 1, "Requested more than expected")
    }
}
