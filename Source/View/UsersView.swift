import Foundation
import CleanArchitecture

class UsersView:View<UsersPresenter, UIView> {
    override func didLoad() {
        super.didLoad()
        self.configureView()
    }
    
    private func configureView() {
        self.title = NSLocalizedString("UsersView_Title", comment:String())
        if #available(iOS 11.0, *) {
            self.navigationItem.largeTitleDisplayMode = UINavigationItem.LargeTitleDisplayMode.always
        }
    }
}
