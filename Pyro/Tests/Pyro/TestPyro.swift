import XCTest
@testable import Pyro

class TestPyro:XCTestCase {
    private var pyro:Pyro!
    private var storage:MockStorageProtocol!
    
    override func setUp() {
        super.setUp()
        self.pyro = Pyro()
        self.storage = MockStorageProtocol()
        self.pyro.storage = self.storage
    }
    
    func testLoadUsersFromStorage() {
        let expect:XCTestExpectation = self.expectation(description:"Storage not called")
        
        let invalidName:String = "invalid"
        var user:User = User()
        user.name = invalidName
        self.pyro.store.users.append(user)
        
        self.storage.onLoad = { expect.fulfill() }
        self.pyro.load { XCTAssertTrue(self.pyro.users.isEmpty, "Failed to replace users") }
        self.waitForExpectations(timeout:0.3, handler:nil)
    }
    
    func testSaveCallsStorage() {
        let expect:XCTestExpectation = self.expectation(description:"Storage not called")
        self.storage.onSave = { expect.fulfill() }
        self.pyro.save()
        self.waitForExpectations(timeout:0.3, handler:nil)
    }
    
    func testAddUserAssignsIdentifier() {
        
    }
    
    func testAddUserSortsTheUserList() {
        
    }
}
