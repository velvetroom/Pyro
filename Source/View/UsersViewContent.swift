import UIKit

class UsersViewContent:UICollectionView {
    init() {
        super.init(frame:CGRect.zero, collectionViewLayout:UICollectionViewFlowLayout())
        self.configureView()
        self.configureFlow()
    }
    
    required init?(coder:NSCoder) {
        return nil
    }
    
    private func configureView() {
        self.backgroundColor = UIColor(white:0.96, alpha:1)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
        self.showsVerticalScrollIndicator = true
        self.showsHorizontalScrollIndicator = false
        self.alwaysBounceVertical = true
        self.alwaysBounceHorizontal = false
        self.register(UsersViewContentCell.self, forCellWithReuseIdentifier:UsersConstants.Collection.identifier)
    }
    
    private func configureFlow() {
        let flow:UICollectionViewFlowLayout = self.collectionViewLayout as! UICollectionViewFlowLayout
        flow.scrollDirection = UICollectionViewScrollDirection.vertical
        flow.minimumInteritemSpacing = UsersConstants.Collection.cellSeparation
        flow.minimumLineSpacing = UsersConstants.Collection.cellSeparation
        flow.headerReferenceSize = CGSize.zero
        flow.footerReferenceSize = CGSize.zero
        flow.sectionInset = UIEdgeInsetsMake(
            UsersConstants.Collection.cellSeparation, 0, UsersConstants.Collection.cellSeparation, 0)
    }
}
