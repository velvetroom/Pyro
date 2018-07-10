import XCTest
@testable import Pyro

class TestLoad:XCTestCase {
    private var load:Load!
    private var delegate:MockLoadDelegate!
    private var request:MockRequestProtocol!

    override func setUp() {
        self.load = Load()
        self.delegate = MockLoadDelegate()
        self.request = MockRequestProtocol()
        self.load.user = User()
        self.load.delegate = self.delegate
        self.load.request = self.request
    }

    func testSendsLoadedItemsToDelegate() {
        var received:Bool = false
        self.delegate.onCompleted = { received = true }
        self.load.start()
        XCTAssertTrue(received, "Not received")
    }
}
