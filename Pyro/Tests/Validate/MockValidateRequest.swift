import Foundation
@testable import Pyro

class MockValidateRequest:RequestProtocol {
    static var error:Error?
    
    required init() { }
    
    func validate(url:String, onCompletion:@escaping((Data) -> Void), onError:@escaping((Error) -> Void)) {
        if let error:Error = MockValidateRequest.error {
            onError(error)
        } else {
            onCompletion(Data())
        }
    }
    
    func make(user:UserProtocol, year:Int, onCompletion:@escaping((Data) -> Void), onError:@escaping((Error) -> Void)) {
    }
}
