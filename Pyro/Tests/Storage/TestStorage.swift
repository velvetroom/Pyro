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
        let expectDefaults:XCTestExpectation = self.expectation(description:"Not saving to defualts")
        self.userDefaults.onSaving = {expectDefaults.fulfill() }
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
    
    func testSaveUsers() {
        let expectSave:XCTestExpectation = self.expectation(description:"Failed to save users")
        let expectDefaults:XCTestExpectation = self.expectation(description:"Not saved to user defaults")
        self.userDefaults.onSaving = { expectDefaults.fulfill() }
        self.storage.save(users:[]) {
            XCTAssertEqual(Thread.current, Thread.main, "Should be main thread")
            expectSave.fulfill()
        }
        self.waitForExpectations(timeout:0.3, handler:nil)
    }
    
    func testLoadUsersNotFirstTime() {
        let expectLoad:XCTestExpectation = self.expectation(description:"Failed to load users")
        var user:User = User()
        user.name = "lorem ipsum"
        user.url = "hello world"
        self.storage.save(users:[user]) {
            self.storage.load { (users:[User]) in
                let first:User? = users.first
                XCTAssertNotNil(first, "Failed to load user")
                XCTAssertEqual(user.name, first?.name, "Invalid")
                XCTAssertEqual(user.url, first?.url, "Invalid")
                expectLoad.fulfill()
            }
        }
        self.waitForExpectations(timeout:0.3, handler:nil)
    }
}
