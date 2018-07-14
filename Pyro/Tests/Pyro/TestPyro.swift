import XCTest
@testable import Pyro

class TestPyro:XCTestCase {
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
    
    func testLoadUsersFromStorage() {
        let expectStorage:XCTestExpectation = self.expectation(description:"Storage not called")
        let expectDelegate:XCTestExpectation = self.expectation(description:"Delegate not notified")
        
        let invalidName:String = "invalid"
        let user:User = User()
        user.name = invalidName
        self.pyro.users.append(user)
        
        self.storage.onLoad = { expectStorage.fulfill() }
        self.delegate.onUpdated = { expectDelegate.fulfill() }
        self.pyro.load()
        self.waitForExpectations(timeout:0.3, handler:nil)
        XCTAssertTrue(self.pyro.users.isEmpty, "Failed to replace users")
    }
    
    func testSaveCallsStorage() {
        let expect:XCTestExpectation = self.expectation(description:"Storage not called")
        self.storage.onSave = { expect.fulfill() }
        self.pyro.save()
        self.waitForExpectations(timeout:0.3, handler:nil)
    }
    
    func testAddUserAssignsIdentifier() {
        let name:String = "hello world"
        let url:String = "lorem ipsum"
        self.pyro.addUser(name:name, url:url)
        XCTAssertFalse(self.pyro.users.isEmpty, "Failed to add")
        guard let user:User = self.pyro.users.first else { return }
        XCTAssertEqual(user.name, name, "Not assigned")
        XCTAssertEqual(user.url, url, "Not assigned")
        XCTAssertFalse(user.identifier.isEmpty, "Not assigned")
    }
    
    func testAddUserSortsUsersByName() {
        let nameA:String = "abc"
        let nameB:String = "fgh"
        let nameC:String = "xyz"
        self.pyro.addUser(name:nameB, url:String())
        self.pyro.addUser(name:nameA, url:String())
        self.pyro.addUser(name:nameC, url:String())
        XCTAssertFalse(self.pyro.users.isEmpty, "Failed to add")
        if self.pyro.users.isEmpty { return }
        
        XCTAssertEqual(self.pyro.users[0].name, nameA, "Not sorted")
        XCTAssertEqual(self.pyro.users[1].name, nameB, "Not sorted")
        XCTAssertEqual(self.pyro.users[2].name, nameC, "Not sorted")
    }
    
    func testAddUserSaves() {
        let expectStorage:XCTestExpectation = self.expectation(description:"Storage not called")
        let expectDelegate:XCTestExpectation = self.expectation(description:"Delegate not notified")
        self.storage.onSave = { expectStorage.fulfill() }
        self.delegate.onUpdated = { expectDelegate.fulfill() }
        self.pyro.addUser(name:String(), url:String())
        self.waitForExpectations(timeout:0.3, handler:nil)
    }
    
    func testReportCompletedUpdatesDelegate() {
        let expect:XCTestExpectation = self.expectation(description:"Delegate not notified")
        self.delegate.onUpdated = { expect.fulfill() }
        self.pyro.reportCompleted()
        self.waitForExpectations(timeout:0.3, handler:nil)
    }
    
    func testReportErrorNotifiesDelegate() {
        let expect:XCTestExpectation = self.expectation(description:"Delegate not notified")
        self.delegate.onError = { expect.fulfill() }
        self.pyro.reportFailed(error:RequestError.banned)
        self.waitForExpectations(timeout:0.3, handler:nil)
    }
}
