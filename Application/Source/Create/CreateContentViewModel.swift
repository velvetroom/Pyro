import UIKit
import CleanArchitecture

struct CreateContentViewModel:ViewModelProtocol {
    var icon:UIImage?
    var message:String
    var saveEnabled:Bool
    
    init() {
        self.message = String()
        self.saveEnabled = false
    }
}
