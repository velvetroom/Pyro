import UIKit
import CleanArchitecture

class UsersView:View<UsersPresenter, UsersViewContent>, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    override func didLoad() {
        super.didLoad()
        self.configureView()
    }
    
    func collectionView(_:UICollectionView, numberOfItemsInSection section:Int) -> Int {
        return 0
    }
    
    func collectionView(_:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    private func configureView() {
        self.title = NSLocalizedString("UsersView_Title", comment:String())
        if #available(iOS 11.0, *) {
            self.navigationItem.largeTitleDisplayMode = UINavigationItem.LargeTitleDisplayMode.always
        }
    }
}
