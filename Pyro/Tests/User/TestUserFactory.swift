import XCTest
@testable import Pyro

class TestUserFactory:XCTestCase {
    func testMakeAddsIdentifierToUser() {
        let user:Configuration.UserType = UserFactory.make() as! Configuration.UserType
        XCTAssertFalse(user.identifier.isEmpty, "Failed to add identifier")
    }
    
    func testMigrateUserFromV1ToCurrent() {
        let user:User_v1 = User_v1()
        user.identifier = "hello world"
        user.name = "john doe"
        user.url = "lorem ipsum"
        user.metrics = Metrics()
        user.metrics!.streak.max = 100
        let migrated:Configuration.UserType = UserFactory.migrate(user:user) as! Configuration.UserType
        XCTAssertEqual(migrated.identifier, user.identifier, "Failed")
        XCTAssertEqual(migrated.name, user.name, "Failed")
        XCTAssertEqual(migrated.url, user.url, "Failed")
        XCTAssertEqual(migrated.metrics?.streak.max, user.metrics?.streak.max, "Failed")
    }
}
