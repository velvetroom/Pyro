import Foundation

class MockUserDefaults:UserDefaults {
    var onSaving:(() -> Void)?
    private static let suiteName:String = "test"
    
    init() {
        super.init(suiteName:MockUserDefaults.suiteName)!
    }
    
    deinit {
        self.removeSuite(named:MockUserDefaults.suiteName)
    }
    
    override func set(_ value:Any?, forKey defaultName:String) {
        self.onSaving?()
        super.set(value, forKey:defaultName)
    }
}
