import XCTest
@testable import Pyro

class TestReport:XCTestCase {
    private var report:Report!
    private var delegate:MockReportDelegate!
    private var load:MockLoadProtocol!
    private var builder:MockMetricsBuilderProtocol!
    private var user:User!
    
    override func setUp() {
        super.setUp()
        self.report = Report()
        self.delegate = MockReportDelegate()
        self.load = MockLoadProtocol()
        self.builder = MockMetricsBuilderProtocol()
        self.user = User()
        self.report.user = self.user
        self.report.delegate = self.delegate
        self.report.load = self.load
        self.report.builder = self.builder
        self.load.delegate = self.report
    }
    
    func testNotRetainingDelegate() {
        self.delegate = nil
        XCTAssertNil(self.report.delegate, "Retains delegate")
    }
    
    func testCallsDelegateOnSuccess() {
        let expectBuildStats:XCTestExpectation = self.expectation(description:"Stats not builded")
        let expectDelegateReturns:XCTestExpectation = self.expectation(description:"Delegate not called")
        self.load.items = []
        self.builder.onBuild = { expectBuildStats.fulfill() }
        self.delegate.onCompleted = {
            XCTAssertEqual(Thread.current, Thread.main, "Should be on main thread")
            expectDelegateReturns.fulfill()
        }
        self.report.make(user:User())
        self.waitForExpectations(timeout:0.3, handler:nil)
    }
    
    func testCallsDelegateOnError() {
        let expect:XCTestExpectation = self.expectation(description:"Delegate not called")
        self.load.error = RequestError.emptyResponse
        self.delegate.onError = {
            XCTAssertEqual(Thread.current, Thread.main, "Should be on main thread")
            expect.fulfill()
        }
        self.report.make(user:User())
        self.waitForExpectations(timeout:0.3, handler:nil)
    }
    
    func testNotRetainingUser() {
        self.user = nil
        XCTAssertNil(self.report.user, "Retains user")
    }
}
