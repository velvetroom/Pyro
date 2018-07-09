import UIKit
import CleanArchitecture

class UsersView:View<UsersPresenter, UsersViewContent>, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var users:[NSAttributedString]!
    
    override func initProperties() {
        super.initProperties()
        self.users = []
    }
    
    override func didLoad() {
        super.didLoad()
        self.configureView()
        self.configureViewModel()
    }
    
    func collectionView(_:UICollectionView, layout:UICollectionViewLayout, sizeForItemAt:IndexPath) -> CGSize {
        return CGSize(width:self.content.bounds.width, height:UsersConstants.Collection.cellHeight)
    }
    
    func collectionView(_:UICollectionView, numberOfItemsInSection section:Int) -> Int { return self.users.count }
    
    func collectionView(_:UICollectionView, cellForItemAt index:IndexPath) -> UICollectionViewCell {
        let cell:UsersViewContentCell = self.content.dequeueReusableCell(
            withReuseIdentifier:UsersConstants.Collection.identifier, for:index) as! UsersViewContentCell
        cell.label.attributedText = self.users[index.item]
        return cell
    }
    
    private func configureView() {
        self.title = NSLocalizedString("UsersView_Title", comment:String())
        self.content.delegate = self
        self.content.dataSource = self
        if #available(iOS 11.0, *) {
            self.navigationItem.largeTitleDisplayMode = UINavigationItem.LargeTitleDisplayMode.always
        }
    }
    
    private func configureViewModel() {
        var viewModel:UsersViewModel = self.viewModel.property()
        viewModel.observing = { [weak self] (property:UsersViewModel) in
            self?.updated(property:property)
        }
        self.viewModel.update(property:viewModel)
    }
    
    private func updated(property:UsersViewModel) {
        let removeIndexes:[IndexPath] = self.indexesFor(count:users.count)
        let addIndexes:[IndexPath] = self.indexesFor(count:property.users.count)
        self.users = property.users
        self.content.performBatchUpdates({ [weak self] in
            self?.content.deleteItems(at:removeIndexes)
            self?.content.insertItems(at:addIndexes)
        })
    }
    
    private func indexesFor(count:Int) -> [IndexPath] {
        var indexes:[IndexPath] = []
        for index:Int in 0 ..< count {
            indexes.append(IndexPath(item:index, section:0))
        }
        return indexes
    }
}
