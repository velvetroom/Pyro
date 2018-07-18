import UIKit
import CleanArchitecture

class StatsView:View<StatsPresenter, StatsContentView>, UICollectionViewDelegate, UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout {
    weak var delete:UIBarButtonItem!
    weak var synch:UIBarButtonItem!
    var years:[Year]
    
    required init() {
        self.years = []
        super.init()
    }
    
    required init?(coder:NSCoder) { return nil }
    
    override func viewDidLoad() {
        self.configureViewModel()
        self.configureView()
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated:Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setToolbarHidden(false, animated:false)
    }
    
    func collectionView(_:UICollectionView, layout:UICollectionViewLayout, sizeForItemAt:IndexPath) -> CGSize {
        return CGSize(width:Constants.cellWidth, height:self.content.years.bounds.height)
    }
    
    func collectionView(_:UICollectionView, cellForItemAt index:IndexPath) -> UICollectionViewCell {
        let cell:YearsCellView = self.content.years.dequeueReusableCell(
            withReuseIdentifier:String(describing:YearsCellView.self), for:index) as! YearsCellView
        return cell
    }
    
    func collectionView(_:UICollectionView, didSelectItemAt index:IndexPath) {
        
    }
    
    func collectionView(_:UICollectionView, numberOfItemsInSection:Int) -> Int { return self.years.count }
    
    @objc func selectorDelete() {
        self.presenter.deleteUser()
    }
    
    @objc func selectorSynch() {
        
    }
    
    @objc func selectorRefresh() {
        
    }
}

private struct Constants {
    static let cellWidth:CGFloat = 100
}
