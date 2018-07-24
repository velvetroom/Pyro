import Foundation

class SessionFactory {
    class func make() -> SessionProtocol { return Configuration.Session() }
    
    private init() { }
}
