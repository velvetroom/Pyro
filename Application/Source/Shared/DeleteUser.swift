import UIKit

class DeleteUser:UIAlertController {
    weak var presenter:StatsPresenter?
    
    func configureView() {
        self.title = NSLocalizedString("StatsViewDelete_Title", comment:String())
        self.makeOutlets()
        guard
            let name:String = self.presenter?.interactor.user.name,
            let url:String = self.presenter?.interactor.user.url
        else { return }
        self.message = name + " : " + url
    }
    
    private func makeOutlets() {
        let delete:UIAlertAction = UIAlertAction(title:NSLocalizedString("StatsViewDelete_Delete", comment:String()),
                                    style:UIAlertAction.Style.destructive, handler:
        { [weak self] (action:UIAlertAction) in
            self?.presenter?.confirmDelete()
        })
        let cancel:UIAlertAction = UIAlertAction(title:NSLocalizedString("StatsViewDelete_Cancel", comment:String()),
                                                 style:UIAlertAction.Style.cancel)
        self.addAction(cancel)
        self.addAction(delete)
    }
}
