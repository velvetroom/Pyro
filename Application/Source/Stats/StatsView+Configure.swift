import UIKit

extension StatsView {
    func configureView() {
        self.configureViewModel()
        self.configureNavigation()
        self.configureToolbar()
        self.content.years.delegate = self
        self.content.years.dataSource = self
        self.content.years.register(YearsCellView.self, forCellWithReuseIdentifier:YearsCellView.identifier)
        if #available(iOS 11.0, *) {
            self.navigationItem.largeTitleDisplayMode = UINavigationItem.LargeTitleDisplayMode.never
        }
    }
    
    private func configureViewModel() {
        self.presenter.viewModel.observe { [weak self] (property:StatsContentViewModel) in
            self?.updated(property:property)
        }
        self.presenter.viewModel.observe { [weak self] (property:StatsYearsViewModel) in
            self?.updated(property:property)
        }
        self.presenter.viewModel.observe { [weak self] (property:StatsMonthsViewModel) in
            self?.updated(property:property)
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
    
    private func updated(property:StatsContentViewModel) {
        self.delete.isEnabled = property.actionsEnabled
        self.synch.isEnabled = property.actionsEnabled
        self.content.amount.streak.text = property.streak
        self.content.amount.contributions.text = property.contributions
    }
    
    private func updated(property:StatsYearsViewModel) {
        self.years = property.items
        self.content.years.reloadData()
        let lastItem:Int = property.items.count - 1
        if lastItem >= 0 {
            self.content.years.selectItem(at:IndexPath(item:lastItem, section:0), animated:false,
                                          scrollPosition:UICollectionView.ScrollPosition.centeredHorizontally)
        }
        self.presenter.select(year:self.years[lastItem])
    }
    
    private func updated(property:StatsMonthsViewModel) {
        self.content.histogram.update(items:property.items)
    }
}
