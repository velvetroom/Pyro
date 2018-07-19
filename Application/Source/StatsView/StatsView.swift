import UIKit

class StatsView:StatsCollectionView {
    override func viewDidLoad() {
        self.configureViewModel()
        super.viewDidLoad()
    }
    
    private func configureViewModel() {
        self.presenter.viewModel.observe { [weak self] (property:StatsStateViewModel) in
            self?.updated(property:property)
        }
        self.presenter.viewModel.observe { [weak self] (property:StatsContentViewModel) in
            self?.updated(property:property)
        }
        self.presenter.viewModel.observe { [weak self] (property:StatsMonthsViewModel) in
            self?.updated(property:property)
        }
    }
    
    private func updated(property:StatsStateViewModel) {
        self.synch.label.text = property.sync
        self.content.metrics.isHidden = property.metricsHidden
        self.content.needsSync.isHidden = property.needsSynchHidden
        self.content.loading.isHidden = property.loadingHidden
        self.deleteButton.isEnabled = property.actionsEnabled
        self.synchButton.isEnabled = property.actionsEnabled
    }
    
    private func updated(property:StatsContentViewModel) {
        self.content.metrics.amount.streak.attributedText = property.streak
        self.content.metrics.amount.contributions.attributedText = property.contributions
        self.update(items:property.items)
    }
    
    private func update(items:[StatsItem]) {
        self.items = items
        self.collection.reloadData()
        self.showLastYearAfterDelay()
    }
    
    private func updated(property:StatsMonthsViewModel) {
        self.content.metrics.histogram.update(items:property.items)
    }
}
