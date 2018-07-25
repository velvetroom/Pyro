import UIKit

class StatsView:StatsCollectionView {
    override func viewDidLoad() {
        self.configureViewModel()
        super.viewDidLoad()
    }
    
    private func configureViewModel() {
        /*self.presenter.viewModel.observe { [weak self] (property:StatsContentViewModel) in
            self?.updated(property:property)
        }
        self.presenter.viewModel.observe { [weak self] (property:StatsMetricsViewModel) in
            self?.updated(property:property)
        }
        self.presenter.viewModel.observe { [weak self] (property:StatsMessageViewModel) in
            self?.updated(property:property)
        }
        self.presenter.viewModel.observe { [weak self] (property:StatsLoadingViewModel) in
            self?.updated(property:property)
        }
        self.presenter.viewModel.observe { [weak self] (property:StatsMonthsViewModel) in
            self?.updated(property:property)
        }*/
    }
    /*
    private func updated(property:StatsContentViewModel) {
        self.synch.label.text = property.sync
        self.content.metrics.isHidden = property.metricsHidden
        self.content.message.isHidden = property.messageHidden
        self.content.loading.isHidden = property.loadingHidden
        self.deleteButton.isEnabled = property.actionsEnabled
        self.synchButton.isEnabled = property.actionsEnabled
    }
    
    private func updated(property:StatsMetricsViewModel) {
        self.content.metrics.amount.streak.attributedText = property.streak
        self.content.metrics.amount.contributions.attributedText = property.contributions
        self.update(items:property.items)
    }
    
    private func updated(property:StatsMessageViewModel) {
        self.content.message.label.text = property.message
    }
    
    private func updated(property:StatsLoadingViewModel) {
        self.content.progress.setProgress(property.progress, animated:true)
    }
 
    private func update(items:[StatsItem]) {
        self.items = items
        self.collection.reloadData()
        self.showLastYearAfterDelay()
    }
    
    private func updated(property:StatsMonthsViewModel) {
        self.content.metrics.histogram.update(items:property.items)
    }*/
}
