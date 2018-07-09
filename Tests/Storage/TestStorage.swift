import XCTest
@testable import Pyro

class TestStorage:XCTestCase {
    private var storage:Storage!
    private var userDefaults:MockUserDefaults!
    
    override func setUp() {
        super.setUp()
        self.storage = Storage()
        self.userDefaults = MockUserDefaults()
        self.storage.userDefaults = self.userDefaults
    }
    
    func testLoadUsersFirstTime() {
        let expectLoadingUsers:XCTestExpectation = self.expectation(description:"Failed to load users")
        let expectSavingToDefualts:XCTestExpectation = self.expectation(description:"Not saving to defualts")
        self.userDefaults.onSaving = { expectSavingToDefualts.fulfill() }
        self.storage.load { (users:[User]) in
            XCTAssertFalse(users.isEmpty, "No users loaded")
            for user:User in users {
                XCTAssertFalse(user.name.isEmpty, "Not loaded")
                XCTAssertFalse(user.url.isEmpty, "Not loaded")
            }
            XCTAssertEqual(Thread.current, Thread.main, "Should be main thread")
            expectLoadingUsers.fulfill()
        }
        self.waitForExpectations(timeout:0.3, handler:nil)
    }
}
