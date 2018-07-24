import XCTest
@testable import Pyro

class TestUserFactory:XCTestCase {
    func testMakeAddsIdentifierToUser() {
        let user:Configuration.User = UserFactory.make() as! Configuration.User
        XCTAssertFalse(user.identifier.isEmpty, "Failed to add identifier")
    }
    
    func testMigrateUserFromV1ToCurrent() {
        let user:User_v1 = User_v1()
        user.identifier = "hello world"
        user.name = "john doe"
        user.url = "lorem ipsum"
        user.metrics = Metrics()
        user.metrics!.streak.max = 100
        let migrated:Configuration.User = UserFactory.migrate(user:user) as! Configuration.User
        XCTAssertEqual(migrated.identifier, user.identifier, "Failed")
        XCTAssertEqual(migrated.name, user.name, "Failed")
        XCTAssertEqual(migrated.url, user.url, "Failed")
        XCTAssertEqual(migrated.metrics?.streak.max, user.metrics?.streak.max, "Failed")
    }
}
