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
        let expectLoadingFromBundle:XCTestExpectation = self.expectation(description:"Not loading from bundle")
        self.file.onLoadFromBundle = { expectLoadingFromBundle.fulfill() }
        self.file.error = StorageError.fileNotFound
        self.storage.load { (users:[User_v1]) in
            XCTAssertEqual(Thread.current, Thread.main, "Should be main thread")
            expectLoadingUsers.fulfill()
        }
        self.waitForExpectations(timeout:0.3, handler:nil)
    }
    
    func testSaveUsersSendsToFile() {
        let expectSave:XCTestExpectation = self.expectation(description:"Failed to save users")
        self.file.onSave = { expectSave.fulfill() }
        self.storage.save(users:[])
        self.waitForExpectations(timeout:0.3, handler:nil)
    }
    
    func testLoadUsersFromFile() {
        let expectLoad:XCTestExpectation = self.expectation(description:"Failed to load users")
        self.storage.load { (users:[User_v1]) in
            expectLoad.fulfill()
        }
        self.waitForExpectations(timeout:0.3, handler:nil)
    }
    
    func testCreatesNewSessionIfNoneFound() {
        let expectLoading:XCTestExpectation = self.expectation(description:"Failed to load")
        let expectSave:XCTestExpectation = self.expectation(description:"Not saving")
        self.file.onSave = { expectSave.fulfill() }
        self.file.error = StorageError.fileNotFound
        self.storage.load { (session:Session) in
            XCTAssertEqual(Thread.current, Thread.main, "Should be main thread")
            expectLoading.fulfill()
        }
        self.waitForExpectations(timeout:0.3, handler:nil)
    }
    
    func testSaveSessionSendsToFile() {
        let expectSave:XCTestExpectation = self.expectation(description:"Failed to save")
        self.file.onSave = { expectSave.fulfill() }
        self.storage.save(session:Session())
        self.waitForExpectations(timeout:0.3, handler:nil)
    }
    
    func testLoadSessionFromFile() {
        let expectLoad:XCTestExpectation = self.expectation(description:"Failed to load")
        self.storage.load { (session:Session) in
            expectLoad.fulfill()
        }
        self.waitForExpectations(timeout:0.3, handler:nil)
    }
}
