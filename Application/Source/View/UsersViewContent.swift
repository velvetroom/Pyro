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
        self.backgroundColor = UIColor.groupTableViewBackground
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
        flow.scrollDirection = UICollectionView.ScrollDirection.vertical
        flow.minimumInteritemSpacing = 0
        flow.minimumLineSpacing = UsersConstants.Collection.cellSeparation
        flow.headerReferenceSize = CGSize.zero
        flow.footerReferenceSize = CGSize.zero
        flow.sectionInset = UIEdgeInsets(top:UsersConstants.Collection.cellSeparation, left:0,
                                         bottom:UsersConstants.Collection.cellSeparation, right:0)
    }
}
