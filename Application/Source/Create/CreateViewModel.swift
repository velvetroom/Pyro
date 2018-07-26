import UIKit
import CleanArchitecture

struct CreateViewModel:ViewModel {
    var icon:UIImage?
    var message:String
    var user:String
    var bio:NSAttributedString
    var saveEnabled:Bool
    var loadingHidden:Bool
    
    init() {
        self.message = String()
        self.user = String()
        self.bio = NSAttributedString()
        self.saveEnabled = false
        self.loadingHidden = true
    }
}
