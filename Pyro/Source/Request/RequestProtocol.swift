import Foundation

protocol RequestProtocol {
    func make(user:UserProtocol, year:Int, onCompletion:@escaping((Data) -> Void), onError:@escaping((Error) -> Void))
}
