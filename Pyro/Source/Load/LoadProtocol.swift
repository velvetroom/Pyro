import Foundation

protocol LoadProtocol {
    var delegate:LoadDelegate? { get set }
    
    func start(user:User_v1)
}
