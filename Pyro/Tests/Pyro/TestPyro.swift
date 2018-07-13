import XCTest
@testable import Pyro

class TestPyro:XCTestCase {
    private var pyro:Pyro!
    private var storage:MockStorageProtocol!
    private var report:MockReportProtocol!
    private var reportDelegate:MockReportDelegate!
    
    override func setUp() {
        super.setUp()
        self.pyro = Pyro()
        self.storage = MockStorageProtocol()
        self.report = MockReportProtocol()
        self.reportDelegate = MockReportDelegate()
        self.pyro.storage = self.storage
        self.pyro.report = self.report
    }
    
    func testLoadUsersFromStorage() {
        let expect:XCTestExpectation = self.expectation(description:"Storage not called")
        
        let invalidName:String = "invalid"
        var user:User = User()
        user.name = invalidName
        self.pyro.users.append(user)
        
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
        let expect:XCTestExpectation = self.expectation(description:"Not saved")
        self.storage.onSave = { expect.fulfill() }
        self.pyro.addUser(name:String(), url:String())
        self.waitForExpectations(timeout:0.3, handler:nil)
    }
    
    func testMakeReportAssignsDelegateToReport() {
        let expect:XCTestExpectation = self.expectation(description:"Not saved")
        self.report.onReport = {
            XCTAssertNotNil(self.report.delegate, "Not assigned")
            expect.fulfill()
        }
        self.pyro.makeReport(user:User(), delegate:self.reportDelegate)
        self.waitForExpectations(timeout:0.3, handler:nil)
    }
}
