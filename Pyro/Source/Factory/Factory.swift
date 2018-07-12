import Foundation

public class Factory {
    public class func makePyro() -> PyroProtocol { return Pyro() }
    
    private init() { }
}
