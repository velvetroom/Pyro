import UIKit
import CleanArchitecture

class UsersView:View<UsersPresenter, UsersViewContent>, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private var users:[NSAttributedString]!
    
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
    
    func collectionView(_:UICollectionView, cellForItemAt index:IndexPath) -> UICollectionViewCell {
        let cell:UsersViewContentCell = self.content.dequeueReusableCell(
            withReuseIdentifier:UsersConstants.Collection.identifier, for:index) as! UsersViewContentCell
        cell.label.attributedText = self.users[index.item]
        return cell
    }
    
    func collectionView(_:UICollectionView, didSelectItemAt index:IndexPath) { self.presenter.selectUser(index:index) }
    func collectionView(_:UICollectionView, numberOfItemsInSection section:Int) -> Int { return self.users.count }
    
    private func configureView() {
        self.title = NSLocalizedString("UsersView_Title", comment:String())
        self.content.delegate = self
        self.content.dataSource = self
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem:UIBarButtonItem.SystemItem.add,
                                                                 target:self, action:#selector(self.selectorAdd))
        if #available(iOS 11.0, *) {
            self.navigationItem.largeTitleDisplayMode = UINavigationItem.LargeTitleDisplayMode.always
        }
    }
    
    private func configureViewModel() {
        self.presenter.viewModel.observe { [weak self] (property:UsersViewModel) in
            self?.updated(property:property)
        }
    }
    
    private func updated(property:UsersViewModel) {
        let removeIndexes:[IndexPath] = self.indexesFor(count:self.users.count)
        let addIndexes:[IndexPath] = self.indexesFor(count:property.users.count)
        self.content.performBatchUpdates({ [weak self] in
            self?.content.deleteItems(at:removeIndexes)
            self?.content.insertItems(at:addIndexes)
            self?.users = property.users
        })
    }
    
    private func indexesFor(count:Int) -> [IndexPath] {
        var indexes:[IndexPath] = []
        for index:Int in 0 ..< count {
            indexes.append(IndexPath(item:index, section:0))
        }
        return indexes
    }
    
    @objc private func selectorAdd() {
        self.presenter.addNew()
    }
}
