import UIKit

extension UsersView {
    func configureView() {
        self.title = NSLocalizedString("UsersView_Title", comment:String())
        self.content.delegate = self
        self.content.dataSource = self
        self.content.register(UsersCellView.self, forCellWithReuseIdentifier:UsersCellView.identifier)
        self.configureNavigationBar()
        self.configureToolBar()
    }
    
    func configureViewModel() {
        self.presenter.viewModel.observe { [weak self] (property:UsersViewModel) in
            self?.updated(property:property)
        }
    }
    
    private func configureNavigationBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem:UIBarButtonItem.SystemItem.add,
                                                                 target:self, action:#selector(self.selectorAdd))
        if #available(iOS 11.0, *) {
            self.navigationItem.largeTitleDisplayMode = UINavigationItem.LargeTitleDisplayMode.always
        }
    }
    
    private func configureToolBar() {
        let segmented:UISegmentedControl = UISegmentedControl(items:[
            NSLocalizedString("UsersView_Segmented_0", comment:String()),
            NSLocalizedString("UsersView_Segmented_1", comment:String()),
            NSLocalizedString("UsersView_Segmented_2", comment:String())])
        segmented.selectedSegmentIndex = 0
        segmented.addTarget(self, action:#selector(self.selectorSort(segmented:)), for:UIControl.Event.valueChanged)
        let flexSpace:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem:UIBarButtonItem.SystemItem.flexibleSpace,
                                                        target:nil, action:nil)
        let barSegmented:UIBarButtonItem = UIBarButtonItem(customView:segmented)
        self.setToolbarItems([barSegmented, flexSpace], animated:false)
    }
    
    private func updated(property:UsersViewModel) {
        self.content.performBatchUpdates({ [weak self] in
            self?.content.deleteSections(IndexSet(integer:0))
            self?.content.insertSections(IndexSet(integer:0))
            self?.users = property.users
        })
    }
}
