import Foundation

protocol ValidateProtocol:AnyObject {
    var delegate:ValidateDelegate? { get set }
    
    init()
    func validate(pyro:Pyro, url:String)
}
