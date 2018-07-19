import UIKit
import Pyro

class StatsFactory {
    private let numberFormatter:NumberFormatter
    
    init() {
        self.numberFormatter = NumberFormatter()
        self.numberFormatter.numberStyle = NumberFormatter.Style.decimal
        self.numberFormatter.groupingSeparator = ","
    }
    
    func makeContent(stats:Metrics) -> StatsContentViewModel {
        var property:StatsContentViewModel = StatsContentViewModel()
        property.actionsEnabled = true
//        property.streak = self.makeStreak(stats:stats)
//        property.contributions = self.makeContributions(stats:stats)
        return property
    }
    
    func makeYears(stats:Metrics) -> StatsYearsViewModel {
        var property:StatsYearsViewModel = StatsYearsViewModel()
//        if stats.histogram.months.count > 0 {
//            property.items = self.yearsFor(histogram:stats.histogram)
//        }
        return property
    }
    /*
    private func makeStreak(stats:Stats) -> NSAttributedString {
        let string:NSMutableAttributedString = NSMutableAttributedString()
        string.append(self.valueWith(value:stats.streak.max, fontSize:Constants.streakFontSize))
        string.append(self.titleWith(string:NSLocalizedString("StatsViewContent_StreakTitle", comment:String())))
        return string
    }
    
    private func makeContributions(stats:Stats) -> NSAttributedString {
        let string:NSMutableAttributedString = NSMutableAttributedString()
        string.append(self.valueWith(value:stats.contributions.count, fontSize:Constants.contributionsFontSize))
        string.append(self.titleWith(string:NSLocalizedString("StatsViewContent_ContributionsTitle", comment:String())))
        return string
    }
    
    private func yearsFor(histogram:StatsSpan) -> [Year] {
        var years:[Year] = []
        var year:Year = Year()
        year.value = histogram.months.first!.year
        let max:CGFloat = -CGFloat(histogram.maxValue)
        for month:StatsMonth in histogram.months {
            if year.value != month.year {
                years.append(year)
                year = Year()
                year.value = month.year
            }
            var item:Month = Month()
            item.contributions = self.makeMonth(month:month)
            item.ratio = max / CGFloat(month.value)
            year.months.append(item)
        }
        years.append(year)
        return years
    }
    
    private func makeMonth(month:ContributionsMonth) -> NSAttributedString {
        let string:NSMutableAttributedString = NSMutableAttributedString()
        string.append(self.valueWith(value:month.value, fontSize:Constants.monthsFontSize))
//        string.append(self.titleWith(string:"\(month.month)/\(month.year)"))
        string.append(self.titleWith(string:NSLocalizedString("StatsViewContent_ContributionsTitle", comment:String())))
        return string
    }
    
    private func valueWith(value:Int, fontSize:CGFloat) -> NSAttributedString {
        return NSAttributedString(string:self.numberFormatter.string(from:NSNumber(value:value))!, attributes:[
            NSAttributedString.Key.font : UIFont.systemFont(ofSize:fontSize, weight:UIFont.Weight.light),
            NSAttributedString.Key.foregroundColor : UIColor.black])
    }
    
    private func titleWith(string:String) -> NSAttributedString {
        return NSAttributedString(string:"\n\(string)", attributes:[NSAttributedString.Key.font :
            UIFont.systemFont(ofSize:Constants.titleFontSize, weight:UIFont.Weight.regular),
            NSAttributedString.Key.foregroundColor : UIColor(white:0, alpha:0.3)])
    }*/
}

private struct Constants {
    static let streakFontSize:CGFloat = 70
    static let contributionsFontSize:CGFloat = 32
    static let monthsFontSize:CGFloat = 20
    static let titleFontSize:CGFloat = 14
}
