import XCTest
@testable import Pyro

class TestStorage_Migration:XCTestCase {
    private var storage:Storage!
    private var file:MockStorageFileProtocol!
    
    override func setUp() {
        super.setUp()
        self.storage = Storage()
        self.file = MockStorageFileProtocol()
        self.storage.file = self.file
    }
    
    func testLoadUsersFromV1() {
        let userA:User_v1 = User_v1()
        let userB:User_v1 = User_v1()
        userA.name = "lorem ipsum"
        userB.name = "hello world"
        XCTAssertNoThrow(try self.file.data = JSONEncoder().encode([userA, userB]))
        XCTAssertFalse(self.file.data.isEmpty, "Failed to encode")
        var loaded:[UserProtocol]?
        XCTAssertNoThrow(try loaded = self.storage.loadStoredUsers(), "Failed to load")
        XCTAssertNotNil(loaded, "Failed load")
        if loaded == nil { return }
        XCTAssertEqual(loaded!.count, 2, "Invalid number of users")
        if loaded!.count != 2 { return }
        XCTAssertEqual(loaded![0].name, userA.name, "Invalid user")
        XCTAssertEqual(loaded![1].name, userB.name, "Invalid user")
    }
}
