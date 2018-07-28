import XCTest
@testable import Pyro

class TestPyro_Session:XCTestCase {
    private var pyro:Pyro!
    private var storage:MockStorageProtocol!
    private var report:MockReportProtocol!
    private var delegate:MockPyroDelegate!
    
    override func setUp() {
        super.setUp()
        self.pyro = Pyro()
        self.storage = MockStorageProtocol()
        self.report = MockReportProtocol()
        self.delegate = MockPyroDelegate()
        self.pyro.storage = self.storage
        self.pyro.report = self.report
        self.pyro.delegate = self.delegate
    }
    
    func testLoadSessionFromStorage() {
        let expect:XCTestExpectation = self.expectation(description:"Storage not called")
        self.pyro.session.reports = -10
    
        self.storage.onLoadSession = { expect.fulfill() }
        self.pyro.loadSession()
        self.waitForExpectations(timeout:0.3, handler:nil)
        XCTAssertEqual(self.pyro.session.reports, 0, "Failed to replace session")
    }
    
    func testSaveSessionCallsStorage() {
        let expect:XCTestExpectation = self.expectation(description:"Storage not called")
        self.storage.onSaveSession = { expect.fulfill() }
        self.pyro.saveSession()
        self.waitForExpectations(timeout:0.3, handler:nil)
    }
    
    func testReportSavesSession() {
        let expect:XCTestExpectation = self.expectation(description:"Storage not called")
        self.pyro.session.reports = 0
        self.storage.onSaveSession = {
            XCTAssertEqual(self.pyro.session.reports, 1, "Failed to increase counter")
            expect.fulfill()
        }
        self.pyro.reportCompleted()
        self.waitForExpectations(timeout:0.3, handler:nil)
    }
    
    func testShouldRateIfReportsMatches3AndNotPreviousRate() {
        self.pyro.session.reports = 3
        XCTAssertTrue(self.pyro.shouldRate(), "Failed to accept app rating")
    }
    
    func testShouldNotRateIfPreviousRate() {
        self.pyro.session.reports = 3
        self.pyro.session.rates = [Date()]
        XCTAssertFalse(self.pyro.shouldRate(), "Failed to deny app rating")
    }
    
    func testShouldNotRateIfReportsLowerThan3() {
        self.pyro.session.reports = 2
        XCTAssertFalse(self.pyro.shouldRate(), "Failed to deny app rating")
    }
    
    func testShouldNotRateIfReportsGreaterThan3() {
        self.pyro.session.reports = 4
        XCTAssertFalse(self.pyro.shouldRate(), "Failed to deny app rating")
    }
    
    func testIfRateSuccessAddRateDate() {
        self.pyro.session.reports = 3
        XCTAssertTrue(self.pyro.shouldRate(), "Failed to accept")
        XCTAssertFalse(self.pyro.session.rates.isEmpty, "Is not adding rate date")
        XCTAssertFalse(self.pyro.shouldRate(), "Should fail")
    }
    
    func testIfRateFailsDontAddDate() {
        XCTAssertFalse(self.pyro.shouldRate(), "Failed to deny app rating")
        XCTAssertTrue(self.pyro.session.rates.isEmpty, "Is adding rate date")
    }
    
    func testRateSuccessSaves() {
        let expect:XCTestExpectation = self.expectation(description:"Storage not called")
        self.storage.onSaveSession = { expect.fulfill() }
        self.pyro.session.reports = 3
        XCTAssertTrue(self.pyro.shouldRate(), "Failed to accept")
        self.waitForExpectations(timeout:0.3, handler:nil)
    }
}
