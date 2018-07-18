import UIKit

extension StatsView {
    func configureView() {
        self.configureNavigation()
        self.configureToolbar()
        self.content.years.delegate = self
        self.content.years.dataSource = self
        self.content.amount.streak.text = "56"
        self.content.amount.contributions.text = "13,456"
        if #available(iOS 11.0, *) {
            self.navigationItem.largeTitleDisplayMode = UINavigationItem.LargeTitleDisplayMode.never
        }
    }
    
    func configureViewModel() {
        self.presenter.viewModel.observe { [weak self] (property:StatsViewModel) in
            self?.delete.isEnabled = property.actionsEnabled
            self?.synch.isEnabled = property.actionsEnabled
        }
    }
    
    private func configureNavigation() {
        let title:StatsTitleView = StatsTitleView()
        title.configure(user:self.presenter.interactor.user)
        let buttonDelete:UIBarButtonItem = UIBarButtonItem(
            title:NSLocalizedString("StatsView_Delete", comment:String()),
            style:UIBarButtonItem.Style.plain, target:self, action:#selector(self.selectorDelete))
        self.delete = buttonDelete
        self.navigationItem.rightBarButtonItem = buttonDelete
        self.navigationItem.titleView = title
    }
    
    private func configureToolbar() {
        let buttonSynch:UIBarButtonItem = UIBarButtonItem(
            title:NSLocalizedString("StatsView_Synch", comment:String()), style:UIBarButtonItem.Style.plain,
            target:self, action:#selector(self.selectorSynch))
        self.synch = buttonSynch
        self.setToolbarItems([buttonSynch], animated:false)
    }
}
