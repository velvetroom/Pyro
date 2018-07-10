import Foundation

protocol RequestProtocol {
    func make(user:User, year:Int, onCompletion:@escaping((Data) -> Void), onError:@escaping((Error) -> Void))
}
