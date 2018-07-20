import UIKit

class YearsView:UICollectionView {
    init() {
        super.init(frame:CGRect.zero, collectionViewLayout:UICollectionViewFlowLayout())
        self.configureView()
        self.configureFlow()
    }
    
    required init?(coder:NSCoder) { return nil }
    override var intrinsicContentSize:CGSize { get { return CGSize(width:UIView.noIntrinsicMetric,
                                                                   height:Constants.height) } }
    
    private func configureView() {
        self.backgroundColor = UIColor.clear
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.alwaysBounceVertical = false
        self.alwaysBounceHorizontal = true
    }
    
    private func configureFlow() {
        let flow:UICollectionViewFlowLayout = self.collectionViewLayout as! UICollectionViewFlowLayout
        flow.scrollDirection = UICollectionView.ScrollDirection.horizontal
        flow.minimumInteritemSpacing = 0
        flow.minimumLineSpacing = 0
        flow.headerReferenceSize = CGSize.zero
        flow.footerReferenceSize = CGSize.zero
        flow.itemSize = CGSize(width:YearsCellView.width, height:Constants.height)
    }
}

private struct Constants {
    static let height:CGFloat = 80
}
