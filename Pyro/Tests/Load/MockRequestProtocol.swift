import Foundation
@testable import Pyro

class MockRequestProtocol:RequestProtocol {
    static var onContributions:((Int) -> Void)?
    static var onValidate:(() -> Void)?
    static var onProfile:(() -> Void)?
    static var data:Data?
    static var error:Error?
    
    class func clear() {
        onContributions = nil
        onValidate = nil
        onProfile = nil
        data = nil
        error = nil
    }
    
    class func contributions(user:UserProtocol, year:Int, onCompletion:@escaping((Data) -> Void),
                             onError:@escaping((Error) -> Void)) {
        self.onContributions?(year)
        if let error:Error = self.error {
            onError(error)
        } else if let data:Data = self.data {
            onCompletion(data)
        }
    }
    
    class func validate(url:String, onCompletion:@escaping((Data) -> Void), onError:@escaping((Error) -> Void)) {
        self.onValidate?()
        if let error:Error = self.error {
            onError(error)
        } else if let data:Data = self.data {
            onCompletion(data)
        }
    }
    
    static func profile(url:String, onCompletion:@escaping((Data) -> Void), onError:@escaping((Error) -> Void)) {
        self.onProfile?()
        if let error:Error = self.error {
            onError(error)
        } else if let data:Data = self.data {
            onCompletion(data)
        }
    }
}
