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
}
