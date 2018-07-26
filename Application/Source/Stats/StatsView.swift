import UIKit
import CleanArchitecture

class StatsView:View<StatsPresenter>,
UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    weak var metrics:StatsMetricsView!
    weak var loading:LoadingView!
    weak var deleteButton:UIBarButtonItem!
    weak var synchButton:UIBarButtonItem!
    weak var synch:UILabel!
    weak var message:UILabel!
    weak var progress:UIProgressView!
    var items:[StatsItem]
    private var trackingScroll:Bool
    
    required init() {
        self.trackingScroll = false
        self.items = []
        super.init()
    }
    
    required init?(coder:NSCoder) { return nil }
    func scrollViewWillBeginDragging(_:UIScrollView) { self.trackingScroll = true }
    func scrollViewDidScroll(_ view:UIScrollView) { if self.trackingScroll { self.selectCentre() } }
    func collectionView(_:UICollectionView, numberOfItemsInSection:Int) -> Int { return self.items.count }
    @objc private func selectorDelete() { self.presenter.deleteUser() }
    @objc private func selectorSynch() { self.presenter.synchronize() }
    
    override func viewDidLoad() {
        self.configureNavigation()
        self.configureToolbar()
        self.configureViewModel()
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.makeOutlets()
        self.layoutOutlets()
    }
    
    override func viewWillAppear(_ animated:Bool) {
        super.viewWillAppear(animated)
        Application.router.setToolbarHidden(false, animated:false)
    }
    
    override func willTransition(to trait:UITraitCollection, with coordinator:UIViewControllerTransitionCoordinator) {
        super.willTransition(to:trait, with:coordinator)
        self.metrics.years.collectionViewLayout.invalidateLayout()
    }
    
    func collectionView(_:UICollectionView, layout:UICollectionViewLayout, insetForSectionAt:Int) -> UIEdgeInsets {
        let margin:CGFloat = (self.metrics.years.bounds.width - StatsMetricsCellView.width) / 2.0
        return UIEdgeInsets(top:0, left:margin, bottom:0, right:margin)
    }
    
    func collectionView(_:UICollectionView, cellForItemAt index:IndexPath) -> UICollectionViewCell {
        let cell:StatsMetricsCellView = self.metrics.years.dequeueReusableCell(
            withReuseIdentifier:StatsMetricsCellView.identifier, for:index) as! StatsMetricsCellView
        cell.label.text = String(self.items[index.item].value)
        return cell
    }
    
    func collectionView(_:UICollectionView, didSelectItemAt index:IndexPath) {
        self.trackingScroll = false
        self.metrics.years.scrollToItem(at:index, at:UICollectionView.ScrollPosition.centeredHorizontally,
                                        animated:true)
        self.presenter.select(item:self.items[index.item])
    }
    
    private func configureNavigation() {
        let string:NSMutableAttributedString = NSMutableAttributedString()
        string.append(NSAttributedString(string:self.presenter.interactor.user.name, attributes: [
            NSAttributedString.Key.font:UIFont.systemFont(ofSize:Constants.titleFont, weight:UIFont.Weight.regular)]))
        string.append(NSAttributedString(string:"\n\(self.presenter.interactor.user.url)", attributes: [
            NSAttributedString.Key.font:UIFont.systemFont(ofSize:Constants.subtitleFont, weight:UIFont.Weight.light)]))
        let title:UILabel = UILabel(frame:CGRect(x:0, y:0, width:Constants.titleWidth, height:Constants.titleHeight))
        title.numberOfLines = 0
        title.textColor = UIColor.black
        title.isUserInteractionEnabled = false
        title.attributedText = string
        self.navigationItem.titleView = title
        
        let buttonDelete:UIBarButtonItem = UIBarButtonItem(
            title:NSLocalizedString("StatsView.delete", comment:String()),
            style:UIBarButtonItem.Style.plain, target:self, action:#selector(self.selectorDelete))
        self.deleteButton = buttonDelete
        self.navigationItem.rightBarButtonItem = buttonDelete
    }
    
    private func configureToolbar() {
        let synch:UILabel = UILabel(frame:CGRect(x:0, y:0, width:Constants.synchWidth, height:Constants.synchHeight))
        synch.isUserInteractionEnabled = false
        synch.font = UIFont.systemFont(ofSize:Constants.synchFont, weight:UIFont.Weight.light)
        synch.numberOfLines = 0
        synch.textColor = UIColor(white:0, alpha:0.5)
        self.synch = synch
        
        let synchButton:UIBarButtonItem = UIBarButtonItem(title:NSLocalizedString("StatsView.synch", comment:String()),
                                style:UIBarButtonItem.Style.plain, target:self, action:#selector(self.selectorSynch))
        self.synchButton = synchButton
        
        self.setToolbarItems([synchButton, UIBarButtonItem(customView:synch)], animated:false)
    }
    
    private func configureViewModel() {
        self.presenter.viewModels.observe { [weak self] (viewModel:StatsContentViewModel) in
            self?.synch.text = viewModel.sync
            self?.metrics.isHidden = viewModel.metricsHidden
            self?.message.isHidden = viewModel.messageHidden
            self?.loading.isHidden = viewModel.loadingHidden
            self?.deleteButton.isEnabled = viewModel.actionsEnabled
            self?.synchButton.isEnabled = viewModel.actionsEnabled
        }
        self.presenter.viewModels.observe { [weak self] (viewModel:StatsMetricsViewModel) in
            self?.items = viewModel.items
            self?.metrics.years.reloadData()
            self?.showLastYearAfterDelay()
            self?.metrics.streak.attributedText = viewModel.streak
            self?.metrics.contributions.attributedText = viewModel.contributions
        }
        self.presenter.viewModels.observe { [weak self] (viewModel:StatsMessageViewModel) in
            self?.message.text = viewModel.message
        }
        self.presenter.viewModels.observe { [weak self] (viewModel:StatsLoadingViewModel) in
            self?.progress.setProgress(viewModel.progress, animated:true)
        }
        self.presenter.viewModels.observe { [weak self] (viewModel:StatsMonthsViewModel) in
            self?.metrics.histogram.update(items:viewModel.items)
        }
    }
    
    private func showLastYearAfterDelay() {
        DispatchQueue.main.asyncAfter(deadline:DispatchTime.now() + 0.3) { [weak self] in self?.showLastYear() }
    }
    
    private func makeOutlets() {
        let metrics:StatsMetricsView = StatsMetricsView()
        metrics.years.delegate = self
        metrics.years.dataSource = self
        metrics.years.register(StatsMetricsCellView.self, forCellWithReuseIdentifier:StatsMetricsCellView.identifier)
        self.metrics = metrics
        self.view.addSubview(metrics)
        
        let message:UILabel = UILabel()
        message.translatesAutoresizingMaskIntoConstraints = false
        message.isUserInteractionEnabled = false
        message.textColor = UIColor(white:0.5, alpha:1)
        message.font = UIFont.systemFont(ofSize:Constants.messageFont, weight:UIFont.Weight.light)
        message.numberOfLines = 0
        self.message = message
        self.view.addSubview(message)
        
        let loading:LoadingView = LoadingView()
        loading.tintColor = UIColor.sharedBlue
        self.loading = loading
        self.view.addSubview(loading)
        
        let progress:UIProgressView = UIProgressView()
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.trackTintColor = UIColor(white:0, alpha:0.1)
        progress.progressTintColor = UIColor.sharedBlue
        progress.isUserInteractionEnabled = false
        self.progress = progress
        self.view.addSubview(progress)
    }
    
    private func layoutOutlets() {
        self.metrics.topAnchor.constraint(equalTo:self.view.topAnchor).isActive = true
        self.metrics.leftAnchor.constraint(equalTo:self.view.leftAnchor).isActive = true
        self.metrics.rightAnchor.constraint(equalTo:self.view.rightAnchor).isActive = true
        
        self.message.bottomAnchor.constraint(equalTo:self.view.bottomAnchor).isActive = true
        self.message.leftAnchor.constraint(equalTo:self.view.leftAnchor,
                                           constant:Constants.messageMargin).isActive = true
        self.message.rightAnchor.constraint(equalTo:self.view.rightAnchor,
                                            constant:Constants.messageMargin).isActive = true
        
        self.loading.centerXAnchor.constraint(equalTo:self.view.centerXAnchor).isActive = true
        self.loading.centerYAnchor.constraint(equalTo:self.view.centerYAnchor).isActive = true
        
        self.progress.leftAnchor.constraint(equalTo:self.view.leftAnchor).isActive = true
        self.progress.rightAnchor.constraint(equalTo:self.view.rightAnchor).isActive = true
        
        if #available(iOS 11.0, *) {
            self.navigationItem.largeTitleDisplayMode = UINavigationItem.LargeTitleDisplayMode.never
            self.progress.bottomAnchor.constraint(equalTo:self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            self.metrics.bottomAnchor.constraint(equalTo:self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            self.message.topAnchor.constraint(equalTo:self.view.safeAreaLayoutGuide.topAnchor,
                                              constant:Constants.messageMargin).isActive = true
        } else {
            self.progress.bottomAnchor.constraint(equalTo:self.view.bottomAnchor).isActive = true
            self.metrics.bottomAnchor.constraint(equalTo:self.view.bottomAnchor).isActive = true
            self.message.topAnchor.constraint(equalTo:self.view.topAnchor,
                                              constant:Constants.messageMargin).isActive = true
        }
    }
    
    private func showLastYear() {
        guard self.items.count > 0 else { return }
        self.metrics.years.selectItem(at:IndexPath(item:self.items.count - 1, section:0), animated:true,
                                      scrollPosition:UICollectionView.ScrollPosition.centeredHorizontally)
        self.presenter.select(item:self.items.last!)
    }
    
    private func selectCentre() {
        guard let indexPath:IndexPath = self.centreIndex else { return }
        self.metrics.years.selectItem(at:indexPath, animated:false, scrollPosition:UICollectionView.ScrollPosition())
        self.presenter.select(item:self.items[indexPath.item])
    }
    
    private var centreIndex:IndexPath? { get {
        let centre:CGPoint = CGPoint(x:self.view.bounds.width / 2.0 + self.metrics.years.contentOffset.x, y:0)
        return self.metrics.years.indexPathForItem(at:centre)
    } }
}

private struct Constants {
    static let titleWidth:CGFloat = 2000
    static let titleHeight:CGFloat = 44
    static let titleFont:CGFloat = 14
    static let subtitleFont:CGFloat = 10
    static let messageFont:CGFloat = 16
    static let messageMargin:CGFloat = 20
    static let synchWidth:CGFloat = 200
    static let synchHeight:CGFloat = 34
    static let synchFont:CGFloat = 11
}
