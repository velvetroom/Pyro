import Foundation

protocol RequestProtocol {
    init()
    func make(user:UserProtocol, year:Int, onCompletion:@escaping((Data) -> Void), onError:@escaping((Error) -> Void))
    func validate(url:String, onCompletion:@escaping(() -> Void), onError:@escaping((Error) -> Void))
}
