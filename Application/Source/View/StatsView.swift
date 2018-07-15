import UIKit
import CleanArchitecture

class StatsView:View<StatsPresenter, StatsViewContent>, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    weak var buttonDelete:UIBarButtonItem!
    weak var buttonSynch:UIBarButtonItem!
    private var stats:[StatsViewModelItem]
    
    required init() {
        self.stats = []
        super.init()
    }
    
    required init?(coder:NSCoder) { return nil }
    
    override func viewDidLoad() {
        self.configureNavigationItems()
        self.configureViewModel()
        super.viewDidLoad()
        self.configureView()
    }
    
    override func viewWillAppear(_ animated:Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setToolbarHidden(true, animated:false)
    }
    
    func collectionView(_:UICollectionView, layout:UICollectionViewLayout, sizeForItemAt:IndexPath) -> CGSize {
        return CGSize(width:self.content.bounds.width, height:Constants.cellHeight)
    }
    
    func collectionView(_:UICollectionView, cellForItemAt index:IndexPath) -> UICollectionViewCell {
        let cell:StatsViewCell = self.content.dequeueReusableCell(
            withReuseIdentifier:String(describing:StatsViewCell.self), for:index) as! StatsViewCell
        cell.labelName.text = self.stats[index.item].name
        cell.labelValue.text = self.stats[index.item].value
        return cell
    }
    
    func collectionView(_:UICollectionView, numberOfItemsInSection section:Int) -> Int { return self.stats.count }
    func collectionView(_:UICollectionView, shouldSelectItemAt:IndexPath) -> Bool { return false }
    func collectionView(_:UICollectionView, shouldHighlightItemAt:IndexPath) -> Bool { return false }
    
    override func willTransition(to newCollection:UITraitCollection,
                                 with coordinator:UIViewControllerTransitionCoordinator) {
        super.willTransition(to:newCollection, with:coordinator)
        self.content.collectionViewLayout.invalidateLayout()
    }
    
    private func configureView() {
        self.title = self.presenter.interactor.user.name
        self.content.delegate = self
        self.content.dataSource = self
        self.content.register(StatsViewCell.self, forCellWithReuseIdentifier:String(describing:StatsViewCell.self))
        if #available(iOS 11.0, *) {
            self.navigationItem.largeTitleDisplayMode = UINavigationItem.LargeTitleDisplayMode.always
        }
    }
    
    private func configureNavigationItems() {
        let buttonSynch:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem:UIBarButtonItem.SystemItem.refresh,
                                                          target:self, action:#selector(self.selectorSynch))
        self.buttonSynch = buttonSynch
        let buttonDelete:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem:UIBarButtonItem.SystemItem.trash,
                                                           target:self, action:#selector(self.selectorDelete))
        self.buttonDelete = buttonDelete
        self.navigationItem.rightBarButtonItems = [buttonSynch, buttonDelete]
    }
    
    private func configureViewModel() {
        self.presenter.viewModel.observe { [weak self] (property:StatsViewModel) in
            self?.stats = property.items
            self?.buttonDelete.isEnabled = property.actionsEnabled
            self?.buttonSynch.isEnabled = property.actionsEnabled
            self?.content.reloadData()
        }
    }
    
    @objc private func selectorDelete() {
        self.presenter.deleteUser()
    }
    
    @objc private func selectorSynch() {
        self.presenter.synchronize()
    }
}

private struct Constants {
    static let cellHeight:CGFloat = 80
}
