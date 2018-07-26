import XCTest
@testable import Pyro

class TestProfiler:XCTestCase {
    private var profiler:Profiler!
    private var delegate:MockProfilerDelegate!
    private struct Constants {
        static let bio:String = "Founder of @Flight-School and @NSHipster. Writer and developer living in Portland, Oregon. Formerly @apple."
        static let name:String = "Mattt"
        static let user:String = "7659"
    }
    
    override func setUp() {
        super.setUp()
        Configuration.requestType = MockRequestProtocol.self
        self.profiler = Profiler()
        self.delegate = MockProfilerDelegate()
        self.profiler.delegate = self.delegate
    }
    
    override func tearDown() {
        super.tearDown()
        MockRequestProtocol.clear()
    }
    
    func testNotifiesDelegateIfError() {
        let expect:XCTestExpectation = self.expectation(description:"Not notified")
        MockRequestProtocol.error = RequestError.emptyResponse
        self.delegate.onError = {
            XCTAssertEqual(Thread.current, Thread.main, "Should be main thread")
            expect.fulfill()
        }
        self.profiler.load(url:String())
        self.waitForExpectations(timeout:0.3, handler:nil)
    }
    
    func testLoadProfile() {
        let expect:XCTestExpectation = self.expectation(description:"Not notified")
        let url:URL = Bundle(for:type(of:self)).url(forResource:"ProfileMattt", withExtension:"html")!
        do { try MockRequestProtocol.data = Data(contentsOf:url) } catch { }
        self.delegate.onLoaded = { (profile:Profile) in
            XCTAssertEqual(Thread.current, Thread.main, "Should be main thread")
            XCTAssertEqual(profile.bio, Constants.bio, "Invalid")
            XCTAssertEqual(profile.name, Constants.name, "Invalid")
            XCTAssertEqual(profile.user, Constants.user, "Invalid")
            expect.fulfill()
        }
        self.profiler.load(url:String())
        self.waitForExpectations(timeout:0.3, handler:nil)
    }
}
