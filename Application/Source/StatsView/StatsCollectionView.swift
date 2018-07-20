import UIKit

class StatsCollectionView:StatsParentView,
UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var items:[StatsItem]
    var collection:YearsView! { get { return self.content.metrics.years } }
    private var trackingScroll:Bool
    private var centreIndex:IndexPath? {
        get {
            let centre:CGPoint = CGPoint(x:self.collection.bounds.width / 2.0 + self.collection.contentOffset.x, y:0)
            return self.collection.indexPathForItem(at:centre)
        }
    }
    
    required init() {
        self.trackingScroll = false
        self.items = []
        super.init()
    }
    
    required init?(coder:NSCoder) { return nil }
    
    func showLastYearAfterDelay() {
        DispatchQueue.main.asyncAfter(deadline:DispatchTime.now() + Constants.showDelay) { [weak self] in
            self?.showLastYear()
        }
    }
    
    override func viewDidLoad() {
        self.collection.delegate = self
        self.collection.dataSource = self
        self.collection.register(YearsCellView.self, forCellWithReuseIdentifier:YearsCellView.identifier)
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated:Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setToolbarHidden(false, animated:false)
    }
    
    func scrollViewWillBeginDragging(_:UIScrollView) {
        self.trackingScroll = true
    }
    
    func scrollViewDidScroll(_ view:UIScrollView) {
        if self.trackingScroll {
            self.selectCentre()
        }
    }
    
    func collectionView(_:UICollectionView, layout:UICollectionViewLayout, insetForSectionAt:Int) -> UIEdgeInsets {
        let margin:CGFloat = (self.collection.bounds.width - YearsCellView.width) / 2.0
        return UIEdgeInsets(top:0, left:margin, bottom:0, right:margin)
    }
    
    func collectionView(_:UICollectionView, cellForItemAt index:IndexPath) -> UICollectionViewCell {
        let cell:YearsCellView = self.collection.dequeueReusableCell(
            withReuseIdentifier:YearsCellView.identifier, for:index) as! YearsCellView
        cell.label.text = String(self.items[index.item].value)
        return cell
    }
    
    func collectionView(_:UICollectionView, didSelectItemAt index:IndexPath) {
        self.trackingScroll = false
        self.collection.scrollToItem(at:index, at:UICollectionView.ScrollPosition.centeredHorizontally, animated:true)
        self.presenter.select(item:self.items[index.item])
    }
    
    func collectionView(_:UICollectionView, numberOfItemsInSection:Int) -> Int { return self.items.count }
    
    override func willTransition(to newCollection:UITraitCollection,
                                 with coordinator:UIViewControllerTransitionCoordinator) {
        super.willTransition(to:newCollection, with:coordinator)
        self.collection.collectionViewLayout.invalidateLayout()
    }
    
    private func showLastYear() {
        guard self.items.count > 0 else { return }
        self.collection.selectItem(at:IndexPath(item:self.items.count - 1, section:0), animated:true,
                                    scrollPosition:UICollectionView.ScrollPosition.centeredHorizontally)
        self.presenter.select(item:self.items.last!)
    }
    
    private func selectCentre() {
        guard let indexPath:IndexPath = self.centreIndex else { return }
        self.collection.selectItem(at:indexPath, animated:false, scrollPosition:UICollectionView.ScrollPosition())
        self.presenter.select(item:self.items[indexPath.item])
    }
}

private struct Constants {
    static let showDelay:TimeInterval = 0.3
}
