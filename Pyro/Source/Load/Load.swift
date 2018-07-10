import Foundation

class Load {
    weak var delegate:LoadDelegate?
    var request:RequestProtocol
    var user:User!
    
    init() {
        self.request = Request()
    }
    
    func start() {
        
    }
}
