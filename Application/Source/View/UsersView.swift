import UIKit
import CleanArchitecture

class UsersView:View<UsersPresenter, UsersViewContent>, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var users:[NSAttributedString]
    
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
        let cell:UsersViewCell = self.content.dequeueReusableCell(
            withReuseIdentifier:String(describing:UsersViewCell.self), for:index) as! UsersViewCell
        cell.label.attributedText = self.users[index.item]
        return cell
    }
    
    func collectionView(_:UICollectionView, didSelectItemAt index:IndexPath) { self.presenter.selectUser(index:index) }
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
        switch segmented.selectedSegmentIndex {
        case Sort.contributions.rawValue: self.presenter.sortByContributions()
        case Sort.streak.rawValue: self.presenter.sortByStreak()
        default: self.presenter.sortByName()
        }
    }
}

private struct Constants {
    static let cellHeight:CGFloat = 52
}

private enum Sort:Int {
    case name
    case contributions
    case streak
}
