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
        self.configureView()
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated:Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setToolbarHidden(false, animated:false)
    }
    
    func collectionView(_:UICollectionView, layout:UICollectionViewLayout, insetForSectionAt:Int) -> UIEdgeInsets {
        let margin:CGFloat = (self.content.years.bounds.width - YearsCellView.width) / 2.0
        return UIEdgeInsets(top:0, left:margin, bottom:0, right:margin)
    }
    
    func collectionView(_:UICollectionView, cellForItemAt index:IndexPath) -> UICollectionViewCell {
        let cell:YearsCellView = self.content.years.dequeueReusableCell(withReuseIdentifier:YearsCellView.identifier,
                                                                        for:index) as! YearsCellView
        cell.label.text = String(self.years[index.item].value)
        return cell
    }
    
    func collectionView(_:UICollectionView, didSelectItemAt index:IndexPath) {
        self.content.years.scrollToItem(at:index, at:UICollectionView.ScrollPosition.centeredHorizontally,
                                        animated:true)
        self.presenter.select(year:self.years[index.item])
    }
    
    func collectionView(_:UICollectionView, numberOfItemsInSection:Int) -> Int { return self.years.count }
    
    @objc func selectorDelete() {
        self.presenter.deleteUser()
    }
    
    @objc func selectorSynch() {
        self.presenter.synchronize()
    }
    
    @objc func selectorRefresh() {

    }
}
