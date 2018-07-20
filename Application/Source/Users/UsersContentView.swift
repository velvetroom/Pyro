import UIKit

class UsersContentView:UICollectionView {
    init() {
        super.init(frame:CGRect.zero, collectionViewLayout:UICollectionViewFlowLayout())
        self.configureView()
        self.configureFlow()
    }
    
    required init?(coder:NSCoder) { return nil }
    
    private func configureView() {
        self.backgroundColor = UIColor.white
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
        self.showsVerticalScrollIndicator = true
        self.showsHorizontalScrollIndicator = false
        self.alwaysBounceVertical = true
        self.alwaysBounceHorizontal = false
    }
    
    private func configureFlow() {
        let flow:UICollectionViewFlowLayout = self.collectionViewLayout as! UICollectionViewFlowLayout
        flow.scrollDirection = UICollectionView.ScrollDirection.vertical
        flow.minimumInteritemSpacing = 0
        flow.minimumLineSpacing = Constants.interLine
        flow.headerReferenceSize = CGSize.zero
        flow.footerReferenceSize = CGSize.zero
        flow.sectionInset = UIEdgeInsets.zero
    }
}

private struct Constants {
    static let interLine:CGFloat = -1
}
