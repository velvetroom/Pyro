import Foundation
@testable import Pyro

class MockRequestProtocol:RequestProtocol {
    static var onContributions:((Int) -> Void)?
    static var onValidate:(() -> Void)?
    static var data:Data?
    static var error:Error?
    
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
}
