import UIKit
import CleanArchitecture
import Pyro

class StatsStateReady:StatsStateProtocol {
    private let metrics:Metrics
    private let numberFormatter:NumberFormatter
    private let dateFormatter:DateFormatter
    private let paragraph:NSMutableParagraphStyle
    
    init(metrics:Metrics) {
        self.metrics = metrics
        self.numberFormatter = NumberFormatter()
        self.numberFormatter.numberStyle = NumberFormatter.Style.decimal
        self.numberFormatter.groupingSeparator = NSLocalizedString("Grouping.separator", comment:String())
        self.dateFormatter = DateFormatter()
        self.dateFormatter.dateStyle = DateFormatter.Style.long
        self.dateFormatter.timeStyle = DateFormatter.Style.short
        self.paragraph = NSMutableParagraphStyle()
        paragraph.paragraphSpacing = Constants.streakSpacing
    }
    
    func update(viewModels:ViewModels) {
        viewModels.update(viewModel:self.state)
        viewModels.update(viewModel:self.stats)
        viewModels.update(viewModel:self.loading)
    }
    
    private func make(streak:Streak) -> NSAttributedString {
        let string:NSMutableAttributedString = NSMutableAttributedString()
        string.append(self.valueWith(value:streak.max, fontSize:Constants.streakFont))
        string.append(self.titleWith(string:NSLocalizedString("StatsStateReady.streak", comment:String())))
        string.addAttribute(NSAttributedString.Key.paragraphStyle, value:self.paragraph, range:
            NSRange(location:0, length:string.string.count))
        return string
    }
    
    private func make(contributions:Contributions) -> NSAttributedString {
        let string:NSMutableAttributedString = NSMutableAttributedString()
        string.append(self.valueWith(value:contributions.count, fontSize:Constants.contributionsFont))
        string.append(self.titleWith(string:NSLocalizedString("StatsStateReady.contributions", comment:String())))
        return string
    }
    
    private func makeItems(contributions:Contributions) -> [StatsItem] {
        var items:[StatsItem] = []
        let maxContribution:CGFloat = -CGFloat(max(contributions.max.month, Constants.minContributions))
        for year:Year in contributions.years {
            guard year.months.count == Constants.months else { continue }
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
        string.append(self.valueWith(value:month.contributions, fontSize:Constants.monthsFont))
        string.append(self.titleWith(
            string:NSLocalizedString("StatsStateReady.month.\(month.value)", comment:String())))
        return string
    }
    
    private func valueWith(value:Int, fontSize:CGFloat) -> NSAttributedString {
        return NSAttributedString(string:self.numberFormatter.string(from:NSNumber(value:value))!, attributes:[
            NSAttributedString.Key.font : UIFont.systemFont(ofSize:fontSize, weight:UIFont.Weight.light),
            NSAttributedString.Key.foregroundColor : UIColor.black])
    }
    
    private func titleWith(string:String) -> NSAttributedString {
        return NSAttributedString(string:"\n\(string)", attributes:
            [NSAttributedString.Key.font:UIFont.systemFont(ofSize:Constants.titleFont, weight:UIFont.Weight.light),
             NSAttributedString.Key.foregroundColor:UIColor(white:0, alpha:0.5)])
    }
    
    private var state:StatsContentViewModel { get {
        var property:StatsContentViewModel = StatsContentViewModel()
        property.sync = NSLocalizedString("StatsStateReady.sync", comment:String())
        property.sync += self.dateFormatter.string(from:metrics.timestamp)
        property.metricsHidden = false
        property.messageHidden = true
        property.loadingHidden = true
        property.actionsEnabled = true
        return property
    }}
    
    private var stats:StatsMetricsViewModel { get {
        var property:StatsMetricsViewModel = StatsMetricsViewModel()
        property.items = self.makeItems(contributions:self.metrics.contributions)
        property.streak = self.make(streak:self.metrics.streak)
        property.contributions = self.make(contributions:self.metrics.contributions)
        return property
    } }
    
    private var loading:StatsLoadingViewModel { get {
        var property:StatsLoadingViewModel = StatsLoadingViewModel()
        property.progress = Constants.loading
        return property
    } }
}

private struct Constants {
    static let streakSpacing:CGFloat = -8
    static let streakFont:CGFloat = 70
    static let contributionsFont:CGFloat = 34
    static let monthsFont:CGFloat = 28
    static let titleFont:CGFloat = 12
    static let loading:Float = 1
    static let minContributions:Int = 1
    static let months:Int = 12
}
