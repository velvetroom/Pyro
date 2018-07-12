import XCTest
@testable import Pyro

class TestStorage:XCTestCase {
    private var storage:Storage!
    private var file:MockStorageFileProtocol!
    
    override func setUp() {
        super.setUp()
        self.storage = Storage()
        self.file = MockStorageFileProtocol()
        self.storage.file = self.file
    }
    
    func testLoadFromUsersBase() {
        let expectLoadingUsers:XCTestExpectation = self.expectation(description:"Failed to load users")
        let expectSave:XCTestExpectation = self.expectation(description:"Not saving")
        self.file.onSave = { expectSave.fulfill() }
        self.file.error = StorageError.fileNotFound
        self.storage.load { (store:Store) in
            XCTAssertFalse(store.users.isEmpty, "No users loaded")
            for user:User in store.users {
                XCTAssertFalse(user.name.isEmpty, "Not loaded")
                XCTAssertFalse(user.url.isEmpty, "Not loaded")
                XCTAssertFalse(user.identifier.isEmpty, "Failed to assign identifier")
            }
            XCTAssertEqual(Thread.current, Thread.main, "Should be main thread")
            expectLoadingUsers.fulfill()
        }
        self.waitForExpectations(timeout:0.3, handler:nil)
    }
    
    func testSaveSendsToFile() {
        let expectSave:XCTestExpectation = self.expectation(description:"Failed to save users")
        self.file.onSave = { expectSave.fulfill() }
        self.storage.save(store:Store())
        self.waitForExpectations(timeout:0.3, handler:nil)
    }
    
    func testLoadUsersFromFile() {
        let expectLoad:XCTestExpectation = self.expectation(description:"Failed to load users")
        self.storage.load { (store:Store) in
            expectLoad.fulfill()
        }
        self.waitForExpectations(timeout:0.3, handler:nil)
    }
}
