import Foundation
import CleanArchitecture

class StatsView:View<StatsPresenter, StatsViewContent>, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    override func didLoad() {
        super.didLoad()
        self.configureView()
        self.configureViewModel()
    }
    
    func collectionView(_:UICollectionView, layout:UICollectionViewLayout, sizeForItemAt:IndexPath) -> CGSize {
        return CGSize(width:self.content.bounds.width, height:StatsConstants.Collection.cellHeight)
    }
    
    func collectionView(_:UICollectionView, cellForItemAt index:IndexPath) -> UICollectionViewCell {
        let cell:StatsViewContentCell = self.content.dequeueReusableCell(
            withReuseIdentifier:StatsConstants.Collection.identifier, for:index) as! StatsViewContentCell
        return cell
    }
    
    func collectionView(_:UICollectionView, numberOfItemsInSection section:Int) -> Int { return 0 }
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
        
    }
}
