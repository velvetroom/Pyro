import UIKit
import CleanArchitecture

class UsersView:View<UsersPresenter, UsersContentView>, UICollectionViewDelegate, UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout {
    var users:[UsersItem]
    
    required init() {
        self.users = []
        super.init()
    }
    
    required init?(coder:NSCoder) { return nil }
    
    override func viewDidLoad() {
        self.configureViewModel()
        super.viewDidLoad()
        self.configureView()
    }
    
    override func viewWillAppear(_ animated:Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setToolbarHidden(false, animated:false)
    }
    
    func collectionView(_:UICollectionView, layout:UICollectionViewLayout, sizeForItemAt:IndexPath) -> CGSize {
        return CGSize(width:self.content.bounds.width, height:Constants.cellHeight)
    }
    
    func collectionView(_:UICollectionView, cellForItemAt index:IndexPath) -> UICollectionViewCell {
        let cell:UsersCellView = self.content.dequeueReusableCell(
            withReuseIdentifier:String(describing:UsersCellView.self), for:index) as! UsersCellView
        cell.name.attributedText = self.users[index.item].name
        cell.value.attributedText = self.users[index.item].value
        return cell
    }
    
    func collectionView(_:UICollectionView, didSelectItemAt index:IndexPath) {
        self.presenter.select(item:self.users[index.item])
    }
    
    func collectionView(_:UICollectionView, numberOfItemsInSection section:Int) -> Int { return self.users.count }
    
    override func willTransition(to newCollection:UITraitCollection,
                                 with coordinator:UIViewControllerTransitionCoordinator) {
        super.willTransition(to:newCollection, with:coordinator)
        self.content.collectionViewLayout.invalidateLayout()
    }
    
    @objc func selectorAdd() {
        self.presenter.createUser()
    }
    
    @objc func selectorSort(segmented:UISegmentedControl) {
        self.presenter.sort = UsersSort(rawValue:segmented.selectedSegmentIndex)!
        self.presenter.shouldUpdate()
    }
}

private struct Constants {
    static let cellHeight:CGFloat = 52
}
