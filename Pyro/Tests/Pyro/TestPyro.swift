import XCTest
@testable import Pyro

class TestPyro:XCTestCase {
    private var pyro:Pyro!
    private var storage:MockStorageProtocol!
    private var report:MockReportProtocol!
    private var delegate:MockPyroDelegate!
    
    override func setUp() {
        super.setUp()
        Configuration.requestType = MockRequestProtocol.self
        self.pyro = Pyro()
        self.storage = MockStorageProtocol()
        self.report = MockReportProtocol()
        self.delegate = MockPyroDelegate()
        self.pyro.storage = self.storage
        self.pyro.report = self.report
        self.pyro.delegate = self.delegate
    }
    
    override func tearDown() {
        super.tearDown()
        MockRequestProtocol.clear()
    }
    
    func testLoadUsersFromStorage() {
        let expectStorage:XCTestExpectation = self.expectation(description:"Storage not called")
        let expectDelegate:XCTestExpectation = self.expectation(description:"Delegate not notified")
        
        let invalidName:String = "invalid"
        let user:UserProtocol = UserFactory.make()
        user.name = invalidName
        self.pyro.users.append(user)
        
        self.storage.onLoadUsers = { expectStorage.fulfill() }
        self.delegate.onUpdated = { expectDelegate.fulfill() }
        self.pyro.loadUsers()
        self.waitForExpectations(timeout:0.3, handler:nil)
        XCTAssertTrue(self.pyro.users.isEmpty, "Failed to replace users")
    }
    
    func testSaveUsersCallsStorage() {
        let expect:XCTestExpectation = self.expectation(description:"Storage not called")
        self.storage.onSaveUsers = { expect.fulfill() }
        self.pyro.saveUsers()
        self.waitForExpectations(timeout:0.3, handler:nil)
    }
    
    func testAddUserAssignsIdentifier() {
        var profile:Profile = Profile()
        profile.name = "hello world"
        profile.url = "lorem ipsum"
        self.pyro.addUser(profile:profile)
        XCTAssertFalse(self.pyro.users.isEmpty, "Failed to add")
        guard let user:Configuration.UserType = self.pyro.users.first as? Configuration.UserType else { return }
        XCTAssertEqual(user.name, profile.name, "Not assigned")
        XCTAssertEqual(user.url, profile.url, "Not assigned")
        XCTAssertFalse(user.identifier.isEmpty, "Not assigned")
    }
    
    func testAddUserSortsUsersByName() {
        var profileA:Profile = Profile()
        var profileB:Profile = Profile()
        var profileC:Profile = Profile()
        profileA.name = "abc"
        profileB.name = "fgh"
        profileC.name = "xyz"
        self.pyro.addUser(profile:profileA)
        self.pyro.addUser(profile:profileB)
        self.pyro.addUser(profile:profileC)
        XCTAssertFalse(self.pyro.users.isEmpty, "Failed to add")
        if self.pyro.users.isEmpty { return }
        
        XCTAssertEqual(self.pyro.users[0].name, profileA.name, "Not sorted")
        XCTAssertEqual(self.pyro.users[1].name, profileB.name, "Not sorted")
        XCTAssertEqual(self.pyro.users[2].name, profileC.name, "Not sorted")
    }
    
    func testAddUserSaves() {
        let expectStorage:XCTestExpectation = self.expectation(description:"Storage not called")
        self.storage.onSaveUsers = { expectStorage.fulfill() }
        self.pyro.addUser(profile:Profile())
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
    
    func testReportCompletedSaves() {
        let expect:XCTestExpectation = self.expectation(description:"Not saved")
        self.storage.onSaveUsers = { expect.fulfill() }
        self.pyro.reportCompleted()
        self.waitForExpectations(timeout:0.3, handler:nil)
    }
    
    func testReportFailedNotSaving() {
        self.storage.onSaveUsers = { XCTFail("Should not save") }
        self.pyro.reportFailed(error:RequestError.banned)
    }
    
    func testMakeReportCallsReporter() {
        let expect:XCTestExpectation = self.expectation(description:"Not reported")
        self.report.onReport = { expect.fulfill() }
        self.pyro.makeReport(user:UserFactory.make())
        self.waitForExpectations(timeout:0.3, handler:nil)
    }
    
    func testDeleteRemovesUser() {
        let user:UserProtocol = UserFactory.make()
        self.pyro.users.append(user)
        self.pyro.delete(user:user)
        XCTAssertTrue(self.pyro.users.isEmpty, "Failed to remove user")
    }
    
    func testDeleteSaves() {
        let expect:XCTestExpectation = self.expectation(description:"Not saved")
        self.storage.onSaveUsers = { expect.fulfill() }
        self.pyro.delete(user:UserFactory.make())
        self.waitForExpectations(timeout:0.3, handler:nil)
    }
    
    func testValidatedUpdatesDelegate() {
        let expect:XCTestExpectation = self.expectation(description:"Delegate not notified")
        self.delegate.onUpdated = { expect.fulfill() }
        self.pyro.validateSuccess()
        self.waitForExpectations(timeout:0.3, handler:nil)
    }
    
    func testValidateErrorNotifiesDelegate() {
        let expect:XCTestExpectation = self.expectation(description:"Delegate not notified")
        self.delegate.onError = { expect.fulfill() }
        self.pyro.validateFailed(error:NSError())
        self.waitForExpectations(timeout:0.3, handler:nil)
    }
    
    func testValidateRemovesComposite() {
        let composite:ValidateComposite = ValidateComposite()
        let validate:Validate = Validate()
        validate.composite = composite
        validate.validate(pyro:self.pyro, url:String())
        XCTAssertFalse(validate.composite === composite, "Not removed")
    }
    
    func testProfileUpdatesDelegate() {
        let expect:XCTestExpectation = self.expectation(description:"Delegate not notified")
        self.delegate.onUpdated = { expect.fulfill() }
        self.pyro.profileLoaded(profile:Profile())
        self.waitForExpectations(timeout:0.3, handler:nil)
    }
    
    func testProfileErrorNotifiesDelegate() {
        let expect:XCTestExpectation = self.expectation(description:"Delegate not notified")
        self.delegate.onError = { expect.fulfill() }
        self.pyro.profileFailed(error:NSError())
        self.waitForExpectations(timeout:0.3, handler:nil)
    }
}
