import Foundation
@testable import Pyro

class MockRequestProtocol:RequestProtocol {
    var onReceived:((Int) -> Void)?
    var data:Data?
    var error:Error?
    
    func make(user:User, year:Int, onCompletion:@escaping((Data) -> Void), onError:@escaping((Error) -> Void)) {
        self.onReceived?(year)
        if let error:Error = self.error {
            onError(error)
        } else if let data:Data = self.data {
            onCompletion(data)
        }
    }
}
