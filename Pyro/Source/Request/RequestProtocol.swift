import Foundation

protocol RequestProtocol {
    func make(user:User_v1, year:Int, onCompletion:@escaping((Data) -> Void), onError:@escaping((Error) -> Void))
}
