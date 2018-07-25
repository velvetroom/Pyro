import UIKit
import CleanArchitecture

class StatsParentView:View<StatsPresenter> {
    weak var deleteButton:UIBarButtonItem!
    weak var synchButton:UIBarButtonItem!
    weak var synch:StatsSynchView!
    
    override func viewDidLoad() {
        self.configureView()
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated:Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setToolbarHidden(false, animated:false)
    }
    
    private func configureView() {
        self.configureNavigation()
        self.configureToolbar()
        if #available(iOS 11.0, *) {
            self.navigationItem.largeTitleDisplayMode = UINavigationItem.LargeTitleDisplayMode.never
        }
    }
    
    private func configureNavigation() {
        let title:StatsTitleView = StatsTitleView()
        title.configure(user:self.presenter.interactor.user)
        let buttonDelete:UIBarButtonItem = UIBarButtonItem(
            title:NSLocalizedString("StatsBaseView_Delete", comment:String()),
            style:UIBarButtonItem.Style.plain, target:self, action:#selector(self.selectorDelete))
        self.deleteButton = buttonDelete
        self.navigationItem.rightBarButtonItem = buttonDelete
        self.navigationItem.titleView = title
    }
    
    private func configureToolbar() {
        let synch:StatsSynchView = StatsSynchView()
        self.synch = synch
        let synchItem:UIBarButtonItem = UIBarButtonItem(customView:synch)
        let buttonSynch:UIBarButtonItem = UIBarButtonItem(
            title:NSLocalizedString("StatsBaseView_Synch", comment:String()), style:UIBarButtonItem.Style.plain,
            target:self, action:#selector(self.selectorSynch))
        self.synchButton = buttonSynch
        self.setToolbarItems([buttonSynch, synchItem], animated:false)
    }
    
    @objc private func selectorDelete() {
        self.presenter.deleteUser()
    }
    
    @objc private func selectorSynch() {
        self.presenter.synchronize()
    }
}
