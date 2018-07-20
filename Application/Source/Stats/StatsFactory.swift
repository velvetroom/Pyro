import UIKit
import Pyro

class StatsFactory {
    private let numberFormatter:NumberFormatter
    private let dateFormatter:DateFormatter
    private let paragraph:NSMutableParagraphStyle
    
    init() {
        self.numberFormatter = NumberFormatter()
        self.numberFormatter.numberStyle = NumberFormatter.Style.decimal
        self.numberFormatter.groupingSeparator = NSLocalizedString("Grouping_Separator", comment:String())
        self.dateFormatter = DateFormatter()
        self.dateFormatter.dateStyle = DateFormatter.Style.long
        self.dateFormatter.timeStyle = DateFormatter.Style.short
        self.paragraph = NSMutableParagraphStyle()
        paragraph.paragraphSpacing = Constants.streakSpacing
    }
    
    func makeState(user:User) -> StatsStateViewModel {
        if let metrics:Metrics = user.metrics {
            return self.makeStateMetrics(metrics:metrics)
        } else {
            return self.makeStateNeedsSynch()
        }
    }
    
    func makeContent(metrics:Metrics) -> StatsContentViewModel {
        var property:StatsContentViewModel = StatsContentViewModel()
        property.items = self.makeItems(contributions:metrics.contributions)
        property.streak = self.make(streak:metrics.streak)
        property.contributions = self.make(contributions:metrics.contributions)
        return property
    }
    
    func makeStateLoading() -> StatsStateViewModel {
        var viewModel:StatsStateViewModel = StatsStateViewModel()
        viewModel.sync = NSLocalizedString("StatsFactory_Loading", comment:String())
        viewModel.metricsHidden = true
        viewModel.messageHidden = true
        viewModel.loadingHidden = false
        viewModel.actionsEnabled = false
        return viewModel
    }
    
    func makeState(error:Error) -> StatsStateViewModel {
        var viewModel:StatsStateViewModel = StatsStateViewModel()
        viewModel.sync = NSLocalizedString("StatsFactory_Error", comment:String())
        viewModel.message = error.localizedDescription
        viewModel.metricsHidden = true
        viewModel.messageHidden = false
        viewModel.loadingHidden = true
        viewModel.actionsEnabled = true
        return viewModel
    }
    
    private func makeStateNeedsSynch() -> StatsStateViewModel {
        var viewModel:StatsStateViewModel = StatsStateViewModel()
        viewModel.sync = NSLocalizedString("StatsFactory_NeedsSync", comment:String())
        viewModel.message = NSLocalizedString("StatsNeedsSyncView_Label", comment:String())
        viewModel.metricsHidden = true
        viewModel.messageHidden = false
        viewModel.loadingHidden = true
        viewModel.actionsEnabled = true
        return viewModel
    }
    
    private func makeStateMetrics(metrics:Metrics) -> StatsStateViewModel {
        var viewModel:StatsStateViewModel = StatsStateViewModel()
        viewModel.sync = NSLocalizedString("StatsFactory_Metrics", comment:String())
        viewModel.sync += self.dateFormatter.string(from:metrics.timestamp)
        viewModel.metricsHidden = false
        viewModel.messageHidden = true
        viewModel.loadingHidden = true
        viewModel.actionsEnabled = true
        return viewModel
    }
    
    private func make(streak:Streak) -> NSAttributedString {
        let string:NSMutableAttributedString = NSMutableAttributedString()
        string.append(self.valueWith(value:streak.max, fontSize:Constants.streakFontSize))
        string.append(self.titleWith(string:NSLocalizedString("StatsViewContent_StreakTitle", comment:String())))
        string.addAttribute(NSAttributedString.Key.paragraphStyle, value:self.paragraph, range:
            NSRange(location:0, length:string.string.count))
        return string
    }
    
    private func make(contributions:Contributions) -> NSAttributedString {
        let string:NSMutableAttributedString = NSMutableAttributedString()
        string.append(self.valueWith(value:contributions.count, fontSize:Constants.contributionsFontSize))
        string.append(self.titleWith(string:NSLocalizedString("StatsViewContent_ContributionsTitle", comment:String())))
        return string
    }
    
    private func makeItems(contributions:Contributions) -> [StatsItem] {
        var items:[StatsItem] = []
        let maxContribution:CGFloat = -CGFloat(max(contributions.max.month, Constants.minContributions))
        for year:Year in contributions.years {
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
        string.append(self.valueWith(value:month.contributions, fontSize:Constants.monthsFontSize))
        string.append(self.titleWith(string:NSLocalizedString("StatsViewContent_ContributionsTitle", comment:String())))
        string.append(self.titleWith(string:NSLocalizedString("Month_\(month.value)", comment:String())))
        return string
    }
    
    private func valueWith(value:Int, fontSize:CGFloat) -> NSAttributedString {
        return NSAttributedString(string:self.numberFormatter.string(from:NSNumber(value:value))!, attributes:[
            NSAttributedString.Key.font : UIFont.systemFont(ofSize:fontSize, weight:UIFont.Weight.light),
            NSAttributedString.Key.foregroundColor : UIColor.black])
    }
    
    private func titleWith(string:String) -> NSAttributedString {
        return NSAttributedString(string:"\n\(string)", attributes:[NSAttributedString.Key.font :
            UIFont.systemFont(ofSize:Constants.titleFontSize, weight:UIFont.Weight.light),
            NSAttributedString.Key.foregroundColor : UIColor(white:0, alpha:0.5)])
    }
}

private struct Constants {
    static let streakSpacing:CGFloat = -8
    static let streakFontSize:CGFloat = 70
    static let contributionsFontSize:CGFloat = 34
    static let monthsFontSize:CGFloat = 28
    static let titleFontSize:CGFloat = 12
    static let minContributions:Int = 1
}
