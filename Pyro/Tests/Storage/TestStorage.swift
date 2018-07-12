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
    
    func testLoadUsersFirstTime() {
        let expectLoadingUsers:XCTestExpectation = self.expectation(description:"Failed to load users")
        let expectSave:XCTestExpectation = self.expectation(description:"Not saving")
        let invalidName:String = "invalid"
        var user:User = User()
        user.name = invalidName
        self.storage.store.users.append(user)
        self.file.onSave = { expectSave.fulfill() }
        self.file.error = StorageError.fileNotFound
        self.storage.load { (users:[User]) in
            XCTAssertFalse(users.isEmpty, "No users loaded")
            for user:User in users {
                XCTAssertNotEqual(user.name, invalidName, "Failed to remove old store before loading new")
                XCTAssertFalse(user.name.isEmpty, "Not loaded")
                XCTAssertFalse(user.url.isEmpty, "Not loaded")
                XCTAssertFalse(user.identifier.isEmpty, "Failed to assign identifier")
            }
            XCTAssertEqual(Thread.current, Thread.main, "Should be main thread")
            expectLoadingUsers.fulfill()
        }
        self.waitForExpectations(timeout:0.3, handler:nil)
    }
    
    func testSaveUsers() {
        let expectSave:XCTestExpectation = self.expectation(description:"Failed to save users")
        self.file.onSave = { expectSave.fulfill() }
        self.storage.save(users:[])
        self.waitForExpectations(timeout:0.3, handler:nil)
    }
    
    func testLoadUsersNotFirstTime() {
        let expectLoad:XCTestExpectation = self.expectation(description:"Failed to load users")
        self.storage.load { (users:[User]) in
            expectLoad.fulfill()
        }
        self.waitForExpectations(timeout:0.3, handler:nil)
    }
}
