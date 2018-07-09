import XCTest
@testable import Pyro

class TestStorage:XCTestCase {
    private var storage:Storage!
    
    override func setUp() {
        super.setUp()
        self.storage = Storage()
    }
    
    func testLoadUsers() {
        let expect:XCTestExpectation = self.expectation(description:"Failed to load users")
        self.storage.load { (users:[User]) in
            expect.fulfill()
        }
        self.waitForExpectations(timeout:0.3, handler:nil)
    }
}
