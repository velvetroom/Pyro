import UIKit
import CleanArchitecture

struct CreateContentViewModel:ViewModelProtocol {
    var icon:UIImage?
    var message:String
    var saveEnabled:Bool
    var loadingHidden:Bool
    
    init() {
        self.message = String()
        self.saveEnabled = false
        self.loadingHidden = true
    }
}
