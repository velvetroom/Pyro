import XCTest
@testable import Pyro

class TestValidate:XCTestCase {
    private var validate:Validate!
    private var delegate:MockValidateDelegate!
    private var pyro:Pyro!
    
    override func setUp() {
        super.setUp()
        Configuration.requestType = MockRequestProtocol.self
        self.validate = Validate()
        self.delegate = MockValidateDelegate()
        self.pyro = Pyro()
        self.validate.delegate = self.delegate
    }
    
    override func tearDown() {
        super.tearDown()
        MockRequestProtocol.data = nil
        MockRequestProtocol.error = nil
        MockRequestProtocol.onContributions = nil
        MockRequestProtocol.onValidate = nil
    }
    
    func testValidatedUpdatesDelegate() {
        let expect:XCTestExpectation = self.expectation(description:"Delegate not notified")
        self.delegate.onValidateSuccess = {
            XCTAssertEqual(Thread.current, Thread.main, "Should be on main thread")
            expect.fulfill()
        }
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async { self.validate.validateSuccess() }
        self.waitForExpectations(timeout:0.3, handler:nil)
    }
    
    func testValidateErrorNotifiesDelegate() {
        let expect:XCTestExpectation = self.expectation(description:"Delegate not notified")
        self.delegate.onValidateError = {
            XCTAssertEqual(Thread.current, Thread.main, "Should be on main thread")
            expect.fulfill()
        }
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async {
            self.validate.validateFailed(error:NSError())
        }
        self.waitForExpectations(timeout:0.3, handler:nil)
    }

    func testValidateEmpty() {
        let expect:XCTestExpectation = self.expectation(description:"Error not thrown")
        self.delegate.onValidateError = { expect.fulfill() }
        self.validate.validate(pyro:self.pyro, url:String())
        self.waitForExpectations(timeout:0.3, handler:nil)
    }
    
    func testValidateStartingWithNumber() {
        let expect:XCTestExpectation = self.expectation(description:"Error not thrown")
        self.delegate.onValidateError = { expect.fulfill() }
        self.validate.validate(pyro:self.pyro, url:"8asd")
        self.waitForExpectations(timeout:0.3, handler:nil)
    }
    
    func testValidateContainsWeirdCharacters() {
        let expect:XCTestExpectation = self.expectation(description:"Error not thrown")
        self.delegate.onValidateError = { expect.fulfill() }
        self.validate.validate(pyro:self.pyro, url:"asd!helloworld")
        self.waitForExpectations(timeout:0.3, handler:nil)
    }
    
    func testAllowMinus() {
        let expect:XCTestExpectation = self.expectation(description:"Error not thrown")
        MockRequestProtocol.data = Data()
        self.delegate.onValidateSuccess = { expect.fulfill() }
        self.validate.validate(pyro:self.pyro, url:"hello-world")
        self.waitForExpectations(timeout:0.3, handler:nil)
    }
    
    func testValidateRepeated() {
        let user:UserProtocol = UserFactory.make()
        user.url = "lorem-ipsum"
        self.pyro.users.append(user)
        let expect:XCTestExpectation = self.expectation(description:"Error not thrown")
        self.delegate.onValidateError = { expect.fulfill() }
        self.validate.validate(pyro:self.pyro, url:user.url)
        self.waitForExpectations(timeout:0.3, handler:nil)
    }
    
    func testValidateExists() {
        MockRequestProtocol.error = RequestError.userNotValid
        let expect:XCTestExpectation = self.expectation(description:"Error not thrown")
        self.delegate.onValidateError = { expect.fulfill() }
        self.validate.validate(pyro:self.pyro, url:"velvetroom")
        self.waitForExpectations(timeout:0.3, handler:nil)
    }
}
