import UIKit

extension StatsView {
    func configureView() {
        self.title = self.presenter.interactor.user.name
        self.content.delegate = self
        self.content.dataSource = self
        self.content.register(StatsViewCell.self, forCellWithReuseIdentifier:String(describing:StatsViewCell.self))
        self.configureNavigation()
        self.configureToolbar()
        if #available(iOS 11.0, *) {
            self.navigationItem.largeTitleDisplayMode = UINavigationItem.LargeTitleDisplayMode.always
        }
    }
    
    func configureViewModel() {
        self.presenter.viewModel.observe { [weak self] (property:StatsViewModel) in
            self?.stats = property.items
            self?.buttonDelete.isEnabled = property.actionsEnabled
            self?.buttonSynch.isEnabled = property.actionsEnabled
            self?.content.reloadData()
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
