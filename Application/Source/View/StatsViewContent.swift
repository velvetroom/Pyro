import UIKit

class StatsViewContent:UICollectionView {
    weak var refresh:UIRefreshControl!
    
    init() {
        super.init(frame:CGRect.zero, collectionViewLayout:UICollectionViewFlowLayout())
        self.configureView()
        self.configureFlow()
        self.configureRefresh()
    }
    
    required init?(coder:NSCoder) {
        return nil
    }
    
    func showRefreshing() {
        let offsetHeight:CGFloat = self.refresh.bounds.height * Constants.refreshHeight
        self.setContentOffset(CGPoint(x:0, y:self.contentOffset.y - offsetHeight), animated:true)
    }
    
    private func configureView() {
        self.backgroundColor = UIColor.groupTableViewBackground
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
        flow.minimumLineSpacing = Constants.separation
        flow.headerReferenceSize = CGSize.zero
        flow.footerReferenceSize = CGSize.zero
        flow.sectionInset = UIEdgeInsets(top:Constants.separation, left:0, bottom:Constants.separation, right:0)
    }
    
    private func configureRefresh() {
        let refresh:UIRefreshControl = UIRefreshControl()
        self.refresh = refresh
        if #available(iOS 10.0, *) {
            self.refreshControl = refresh
        } else {
            self.addSubview(refresh)
        }
    }
}

private struct Constants {
    static let separation:CGFloat = 1
    static let refreshHeight:CGFloat = 0.5
}
