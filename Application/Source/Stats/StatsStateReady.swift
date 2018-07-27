import UIKit
import CleanArchitecture
import Pyro

class StatsStateReady:StatsStateProtocol {
    weak var user:UserProtocol!
    private let numberFormatter:NumberFormatter
    private let dateFormatter:DateFormatter
    private let spacing:NSAttributedString
    private let attributesNumeric:[NSAttributedString.Key:Any]
    private let attributesInfo:[NSAttributedString.Key:Any]
    private let attributesTitle:[NSAttributedString.Key:Any]
    
    init(user:UserProtocol) {
        self.user = user
        self.numberFormatter = NumberFormatter()
        self.numberFormatter.numberStyle = NumberFormatter.Style.decimal
        self.numberFormatter.groupingSeparator = NSLocalizedString("Grouping.separator", comment:String())
        self.dateFormatter = DateFormatter()
        self.dateFormatter.dateStyle = DateFormatter.Style.long
        self.dateFormatter.timeStyle = DateFormatter.Style.short
        self.spacing = NSAttributedString(string:"\n")
        self.attributesNumeric = [NSAttributedString.Key.font:
            UIFont.systemFont(ofSize:Constants.numericFont, weight:UIFont.Weight.light)]
        self.attributesInfo = [NSAttributedString.Key.font:
            UIFont.systemFont(ofSize:Constants.infoFont, weight:UIFont.Weight.light)]
        self.attributesTitle = [NSAttributedString.Key.font:
            UIFont.systemFont(ofSize:Constants.titleFont, weight:UIFont.Weight.light)]
    }
    
    func update(viewModels:ViewModels) {
        viewModels.update(viewModel:self.state)
        viewModels.update(viewModel:self.stats)
        viewModels.update(viewModel:self.loading)
    }
    
    private func makeInfo() -> NSAttributedString {
        let string:NSMutableAttributedString = NSMutableAttributedString()
        string.append(NSAttributedString(string:self.user.bio, attributes:self.attributesInfo))
        string.append(self.spacing)
        string.append(NSAttributedString(string:self.numberFormatter.string(
            from:NSNumber(value:self.user.metrics!.streak.max))!, attributes:self.attributesNumeric))
        string.append(self.spacing)
        string.append(NSAttributedString(string:NSLocalizedString("StatsStateReady.streak", comment:String()),
                                         attributes:self.attributesTitle))
        string.append(self.spacing)
        string.append(NSAttributedString(string:self.numberFormatter.string(
            from:NSNumber(value:self.user.metrics!.contributions.count))!, attributes:self.attributesNumeric))
        string.append(self.spacing)
        string.append(NSAttributedString(string:NSLocalizedString("StatsStateReady.contributions", comment:String()),
                                         attributes:self.attributesTitle))
        return string
    }
    
    private func makeItems() -> [StatsItem] {
        var items:[StatsItem] = []
        let contributions:Contributions = self.user.metrics!.contributions
        let maxContribution:CGFloat = -CGFloat(max(contributions.max.month, Constants.minContributions))
        for year:Year in contributions.years {
            if let firstMonth:Month = year.months.first {
                if firstMonth.value > Constants.firstMonth { continue }
            }
            var item:StatsItem = StatsItem()
            item.value = year.value
            item.months = self.makeMonths(year:year, max:maxContribution)
            items.append(item)
        }
        return items
    }
    
    private func makeMonths(year:Year, max:CGFloat) -> [StatsItemMonth] {
        var items:[StatsItemMonth] = []
        for month:Month in year.months {
            var item:StatsItemMonth = StatsItemMonth()
            item.contributions = self.makeMonthContributions(month:month)
            item.ratio = CGFloat(month.contributions) / max
            items.append(item)
        }
        return items
    }
    
    private func makeMonthContributions(month:Month) -> NSAttributedString {
        let string:NSMutableAttributedString = NSMutableAttributedString()
        string.append(NSAttributedString(string:self.numberFormatter.string(from:NSNumber(value:month.contributions))!,
                                         attributes:self.attributesNumeric))
        string.append(self.spacing)
        string.append(NSAttributedString(string:NSLocalizedString("StatsStateReady.month.\(month.value)",
            comment:String()), attributes:self.attributesTitle))
        return string
    }
    
    private var state:StatsContentViewModel { get {
        var property:StatsContentViewModel = StatsContentViewModel()
        property.sync = NSLocalizedString("StatsStateReady.sync", comment:String())
        property.sync += self.dateFormatter.string(from:self.user.metrics!.timestamp)
        property.metricsHidden = false
        property.messageHidden = true
        property.loadingHidden = true
        property.actionsEnabled = true
        return property
    }}
    
    private var stats:StatsMetricsViewModel { get {
        var property:StatsMetricsViewModel = StatsMetricsViewModel()
        property.items = self.makeItems()
        property.info = self.makeInfo()
        property.avatar = self.user.user
        return property
    } }
    
    private var loading:StatsLoadingViewModel { get {
        var property:StatsLoadingViewModel = StatsLoadingViewModel()
        property.progress = Constants.loading
        return property
    } }
}

private struct Constants {
    static let infoFont:CGFloat = 14
    static let titleFont:CGFloat = 12
    static let numericFont:CGFloat = 30
    static let loading:Float = 1
    static let minContributions:Int = 1
    static let months:Int = 12
    static let firstMonth:Int = 1
}
