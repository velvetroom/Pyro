import Foundation
@testable import Pyro

class MockRequestProtocol:RequestProtocol {
    var onReceived:((Int) -> Void)?
    var data:Data?
    var error:Error?
    
    required init() { }
    
    func make(user:UserProtocol, year:Int, onCompletion:@escaping((Data) -> Void), onError:@escaping((Error) -> Void)) {
        self.onReceived?(year)
        if let error:Error = self.error {
            onError(error)
        } else if let data:Data = self.data {
            onCompletion(data)
        }
    }
    
    func validate(url:String, onCompletion:@escaping(() -> Void), onError:@escaping((Error) -> Void)) { }
}
