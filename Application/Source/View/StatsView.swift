import UIKit
import CleanArchitecture

class StatsView:View<StatsPresenter, StatsViewContent>, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    weak var buttonDelete:UIBarButtonItem!
    weak var buttonSynch:UIBarButtonItem!
    var stats:[StatsViewModelItem]
    
    required init() {
        self.stats = []
        super.init()
    }
    
    required init?(coder:NSCoder) { return nil }
    
    override func viewDidLoad() {
        self.configureViewModel()
        self.configureView()
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated:Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setToolbarHidden(false, animated:false)
    }
    
    func collectionView(_:UICollectionView, layout:UICollectionViewLayout, sizeForItemAt:IndexPath) -> CGSize {
        return CGSize(width:self.content.bounds.width, height:Constants.cellHeight)
    }
    
    func collectionView(_:UICollectionView, cellForItemAt index:IndexPath) -> UICollectionViewCell {
        let cell:StatsViewCell = self.content.dequeueReusableCell(
            withReuseIdentifier:String(describing:StatsViewCell.self), for:index) as! StatsViewCell
        cell.labelName.text = self.stats[index.item].name
        cell.labelValue.text = self.stats[index.item].value
        return cell
    }
    
    func collectionView(_:UICollectionView, numberOfItemsInSection section:Int) -> Int { return self.stats.count }
    func collectionView(_:UICollectionView, shouldSelectItemAt:IndexPath) -> Bool { return false }
    func collectionView(_:UICollectionView, shouldHighlightItemAt:IndexPath) -> Bool { return false }
    
    override func willTransition(to newCollection:UITraitCollection,
                                 with coordinator:UIViewControllerTransitionCoordinator) {
        super.willTransition(to:newCollection, with:coordinator)
        self.content.collectionViewLayout.invalidateLayout()
    }
    
    @objc func selectorDelete() {
        self.presenter.deleteUser()
    }
    
    @objc func selectorSynch() {
        self.content.refresh.beginRefreshing()
        self.content.showRefreshing()
    }
    
    @objc func selectorRefresh() {
        
    }
}

private struct Constants {
    static let cellHeight:CGFloat = 80
}
