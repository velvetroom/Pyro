import UIKit
import CleanArchitecture

class UsersView:View<UsersPresenter>, UICollectionViewDelegate, UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout {
    var users:[UsersItem]
    weak var segmented:UISegmentedControl!
    
    required init() {
        self.users = []
        super.init()
    }
    
    required init?(coder:NSCoder) { return nil }
    
    func collectionView(_:UICollectionView, layout:UICollectionViewLayout, sizeForItemAt:IndexPath) -> CGSize {
        return CGSize(width:self.view.bounds.width, height:Constants.cellHeight)
    }
    
    func collectionView(_ collection:UICollectionView, cellForItemAt index:IndexPath) -> UICollectionViewCell {
        let cell:UsersCellView = collection.dequeueReusableCell(withReuseIdentifier:UsersCellView.identifier,
                                                                for:index) as! UsersCellView
        cell.name.attributedText = self.users[index.item].name
        cell.streak.text = self.users[index.item].value
        cell.avatar.load(user:self.users[index.item].avatar)
        return cell
    }
    
    func collectionView(_:UICollectionView, didSelectItemAt index:IndexPath) {
        self.presenter.select(item:self.users[index.item])
    }
    
    func collectionView(_:UICollectionView, numberOfItemsInSection:Int) -> Int { return self.users.count }
    
    override func loadView() {
        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flow.scrollDirection = UICollectionView.ScrollDirection.vertical
        flow.minimumInteritemSpacing = 0
        flow.minimumLineSpacing = Constants.interLine
        flow.headerReferenceSize = CGSize.zero
        flow.footerReferenceSize = CGSize.zero
        flow.sectionInset = UIEdgeInsets.zero
        
        let collection:UICollectionView = UICollectionView(frame:CGRect.zero, collectionViewLayout:flow)
        collection.backgroundColor = UIColor.white
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.clipsToBounds = true
        collection.showsVerticalScrollIndicator = true
        collection.showsHorizontalScrollIndicator = false
        collection.alwaysBounceVertical = true
        collection.alwaysBounceHorizontal = false
        collection.delegate = self
        collection.dataSource = self
        collection.register(UsersCellView.self, forCellWithReuseIdentifier:UsersCellView.identifier)
        self.view = collection
    }
    
    override func viewDidLoad() {
        self.presenter.viewModels.observe { [weak self] (viewModel:UsersViewModel) in
            self?.updated(viewModel:viewModel)
        }
        
        super.viewDidLoad()
        self.title = NSLocalizedString("UsersView.title", comment:String())
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem:UIBarButtonItem.SystemItem.add,
                                                                 target:self, action:#selector(self.selectorAdd))
        if #available(iOS 11.0, *) {
            self.navigationItem.largeTitleDisplayMode = UINavigationItem.LargeTitleDisplayMode.always
        }
        
        let segmented:UISegmentedControl = UISegmentedControl(items:[
            NSLocalizedString("UsersView.segmented.0", comment:String()),
            NSLocalizedString("UsersView.segmented.1", comment:String())])
        segmented.selectedSegmentIndex = 0
        segmented.addTarget(self, action:#selector(self.selectorSort), for:UIControl.Event.valueChanged)
        self.segmented = segmented
        let flexSpace:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem:UIBarButtonItem.SystemItem.flexibleSpace,
                                                        target:nil, action:nil)
        let barSegmented:UIBarButtonItem = UIBarButtonItem(customView:segmented)
        self.setToolbarItems([flexSpace, barSegmented], animated:false)
    }
    
    override func viewWillAppear(_ animated:Bool) {
        super.viewWillAppear(animated)
        Application.router.setToolbarHidden(false, animated:false)
    }
    
    override func willTransition(to trait:UITraitCollection, with coordinator:UIViewControllerTransitionCoordinator) {
        super.willTransition(to:trait, with:coordinator)
        (self.view as! UICollectionView).collectionViewLayout.invalidateLayout()
    }
    
    private func updated(viewModel:UsersViewModel) {
        let collection:UICollectionView = self.view as! UICollectionView
        collection.performBatchUpdates({ [weak self] in
            collection.deleteSections(IndexSet(integer:0))
            collection.insertSections(IndexSet(integer:0))
            self?.users = viewModel.users
        })
    }
    
    @objc private func selectorAdd() { self.presenter.createUser() }
    
    @objc private func selectorSort() {
        self.presenter.selectedSort = self.segmented.selectedSegmentIndex
        self.presenter.shouldUpdate()
    }
}

private struct Constants {
    static let cellHeight:CGFloat = 60
    static let interLine:CGFloat = -1
}
