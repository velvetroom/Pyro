import Foundation

class MockUserDefaults:UserDefaults {
    var onSaving:(() -> Void)?
    var value:Any?
    private static let suiteName:String = "test"
    
    init() {
        super.init(suiteName:MockUserDefaults.suiteName)!
    }
    
    deinit {
        self.removeSuite(named:MockUserDefaults.suiteName)
    }
    
    override func value(forKey key:String) -> Any? {
        return self.value
    }
    
    override func set(_ value:Any?, forKey defaultName:String) {
        self.onSaving?()
        self.value = value
    }
}
