import UIKit

class StatsViewContent:UICollectionView {
    init() {
        super.init(frame:CGRect.zero, collectionViewLayout:UICollectionViewFlowLayout())
        self.configureView()
        self.configureFlow()
    }
    
    required init?(coder:NSCoder) {
        return nil
    }
    
    private func configureView() {
        self.backgroundColor = UIColor.groupTableViewBackground
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
        self.showsVerticalScrollIndicator = true
        self.showsHorizontalScrollIndicator = false
        self.alwaysBounceVertical = true
        self.alwaysBounceHorizontal = false
        self.register(StatsViewContentCell.self, forCellWithReuseIdentifier:StatsConstants.Collection.identifier)
    }
    
    private func configureFlow() {
        let flow:UICollectionViewFlowLayout = self.collectionViewLayout as! UICollectionViewFlowLayout
        flow.scrollDirection = UICollectionView.ScrollDirection.vertical
        flow.minimumInteritemSpacing = StatsConstants.Collection.cellSeparation
        flow.minimumLineSpacing = StatsConstants.Collection.cellSeparation
        flow.headerReferenceSize = CGSize.zero
        flow.footerReferenceSize = CGSize.zero
        flow.sectionInset = UIEdgeInsets(top:StatsConstants.Collection.cellSeparation, left:0,
                                         bottom:StatsConstants.Collection.cellSeparation, right:0)
    }
}
