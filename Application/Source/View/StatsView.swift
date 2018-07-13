import UIKit
import CleanArchitecture

class StatsView:View<StatsPresenter, StatsViewContent>, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private var stats:[StatsViewModelItem]
    
    required init() {
        self.stats = []
        super.init()
    }
    
    required init?(coder:NSCoder) { return nil }
    
    override func viewDidLoad() {
        self.configureViewModel()
        super.viewDidLoad()
        self.configureView()
    }
    
    func collectionView(_:UICollectionView, layout:UICollectionViewLayout, sizeForItemAt:IndexPath) -> CGSize {
        return CGSize(width:self.content.bounds.width, height:StatsConstants.Collection.cellHeight)
    }
    
    func collectionView(_:UICollectionView, cellForItemAt index:IndexPath) -> UICollectionViewCell {
        let cell:StatsViewContentCell = self.content.dequeueReusableCell(
            withReuseIdentifier:StatsConstants.Collection.identifier, for:index) as! StatsViewContentCell
        cell.labelName.text = self.stats[index.item].name
        cell.labelValue.text = self.stats[index.item].value
        return cell
    }
    
    func collectionView(_:UICollectionView, numberOfItemsInSection section:Int) -> Int { return self.stats.count }
    func collectionView(_:UICollectionView, shouldSelectItemAt:IndexPath) -> Bool { return false }
    func collectionView(_:UICollectionView, shouldHighlightItemAt:IndexPath) -> Bool { return false }
    
    private func configureView() {
        self.title = self.presenter.interactor.user.name
        self.content.delegate = self
        self.content.dataSource = self
        if #available(iOS 11.0, *) {
            self.navigationItem.largeTitleDisplayMode = UINavigationItem.LargeTitleDisplayMode.always
        }
    }
    
    private func configureViewModel() {
        self.presenter.viewModel.observe { [weak self] (property:StatsViewModel) in
            self?.stats = property.items
            self?.content.reloadData()
        }
    }
}
