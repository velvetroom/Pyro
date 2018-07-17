import UIKit
import CleanArchitecture

class StatsView:View<StatsPresenter, StatsContent> {
    weak var delete:UIBarButtonItem!
    weak var synch:UIBarButtonItem!
    
    override func viewDidLoad() {
        self.configureViewModel()
        self.configureView()
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated:Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setToolbarHidden(false, animated:false)
    }
    
    @objc func selectorDelete() {
        self.presenter.deleteUser()
    }
    
    @objc func selectorSynch() {
        
    }
    
    @objc func selectorRefresh() {
        
    }
}
