import UIKit

extension StatsView {
    func configureView() {
        self.configureTitle()
        self.configureNavigation()
        self.configureToolbar()
        self.content.viewStreak.labelAmount.text = "56"
        self.content.viewContributions.labelAmount.text = "13,456"
        if #available(iOS 11.0, *) {
            self.navigationItem.largeTitleDisplayMode = UINavigationItem.LargeTitleDisplayMode.never
        }
    }
    
    func configureViewModel() {
        self.presenter.viewModel.observe { [weak self] (property:StatsViewModel) in
            self?.buttonDelete.isEnabled = property.actionsEnabled
            self?.buttonSynch.isEnabled = property.actionsEnabled
        }
    }
    
    private func configureTitle() {
        let string:NSMutableAttributedString = NSMutableAttributedString()
        string.append(NSAttributedString(string:self.presenter.interactor.user.name,
                                         attributes:[NSAttributedString.Key.font: UIFont.systemFont(
                                            ofSize:Constants.titleFontSize, weight:UIFont.Weight.regular)]))
        string.append(NSAttributedString(string:"\n\(self.presenter.interactor.user.url)",
                                         attributes:[NSAttributedString.Key.font: UIFont.systemFont(
                                            ofSize:Constants.subtitleFontSize, weight:UIFont.Weight.light)]))
        let label:UILabel = UILabel(frame:CGRect(x:0, y:0, width:Constants.titleWidth, height:Constants.titleHeight))
        label.numberOfLines = 0
        label.attributedText = string
        label.textColor = UIColor.black
        label.backgroundColor = UIColor.clear
        self.navigationItem.titleView = label
    }
    
    private func configureNavigation() {
        let buttonDelete:UIBarButtonItem = UIBarButtonItem(
            title:NSLocalizedString("StatsView_Delete", comment:String()),
            style:UIBarButtonItem.Style.plain, target:self, action:#selector(self.selectorDelete))
        self.buttonDelete = buttonDelete
        self.navigationItem.rightBarButtonItem = buttonDelete
    }
    
    private func configureToolbar() {
        let buttonSynch:UIBarButtonItem = UIBarButtonItem(
            title:NSLocalizedString("StatsView_Synch", comment:String()), style:UIBarButtonItem.Style.plain,
            target:self, action:#selector(self.selectorSynch))
        self.buttonSynch = buttonSynch
        self.setToolbarItems([buttonSynch], animated:false)
    }
}

private struct Constants {
    static let titleWidth:CGFloat = 1500
    static let titleHeight:CGFloat = 44
    static let titleFontSize:CGFloat = 14
    static let subtitleFontSize:CGFloat = 10
}
