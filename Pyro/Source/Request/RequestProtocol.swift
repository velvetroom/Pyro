import Foundation

protocol RequestProtocol {
    static func contributions(user:UserProtocol, year:Int,
                              onCompletion:@escaping((Data) -> Void),
                              onError:@escaping((Error) -> Void))
    static func validate(url:String, onCompletion:@escaping((Data) -> Void), onError:@escaping((Error) -> Void))
    static func profile(url:String, onCompletion:@escaping((Data) -> Void), onError:@escaping((Error) -> Void))
}
