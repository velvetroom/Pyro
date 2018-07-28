import Foundation

class SessionFactory {
    class func make() -> SessionProtocol { return Configuration.SessionType() }
    
    private init() { }
}
