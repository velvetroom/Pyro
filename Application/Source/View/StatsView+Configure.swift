import UIKit

extension StatsView {
    func configureView() {
        self.title = self.presenter.interactor.user.name
        self.configureNavigation()
        self.configureToolbar()
        self.content.viewStreak.labelAmount.text = String(self.presenter.interactor.user.stats.streak.max)
        self.content.viewContributions.labelAmount.text = String(self.presenter.interactor.user.stats.contributions.count)
        if #available(iOS 11.0, *) {
            self.navigationItem.largeTitleDisplayMode = UINavigationItem.LargeTitleDisplayMode.never
        }
    }
    
    func configureViewModel() {
        self.presenter.viewModel.observe { [weak self] (property:StatsViewModel) in
            self?.buttonDelete.isEnabled = property.actionsEnabled
            self?.buttonSynch.isEnabled = property.actionsEnabled
        }
    }
    
    private func configureNavigation() {
        let buttonSynch:UIBarButtonItem = UIBarButtonItem(
            title:NSLocalizedString("StatsView_Synch", comment:String()),
            style:UIBarButtonItem.Style.plain, target:self, action:#selector(self.selectorSynch))
        self.buttonSynch = buttonSynch
        self.navigationItem.rightBarButtonItem = buttonSynch
    }
    
    private func configureToolbar() {
        let buttonDelete:UIBarButtonItem = UIBarButtonItem(
            title:NSLocalizedString("StatsView_Delete", comment:String()), style:UIBarButtonItem.Style.plain,
            target:self, action:#selector(self.selectorDelete))
        self.buttonDelete = buttonDelete
        self.setToolbarItems([buttonDelete], animated:false)
    }
}
