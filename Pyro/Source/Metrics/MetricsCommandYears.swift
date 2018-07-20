import Foundation

class MetricsCommandYears:MetricsCommandProtocol {
    private var items:[Year]
    private var year:Year
    private var month:Month
    private var maxYear:Int
    private var maxMonth:Int
    
    init() {
        self.items = []
        self.year = Year()
        self.month = Month()
        self.maxYear = 0
        self.maxMonth = 0
    }
    
    func evaluate(item:ScraperItem) {
        self.evaluateYear(item:item)
        self.evaluateMonth(item:item)
    }
    
    func print(stats:inout Metrics) {
        self.storeYear()
        stats.contributions.years = self.items
        stats.contributions.max.year = self.maxYear
        stats.contributions.max.month = self.maxMonth
    }
    
    private func evaluateYear(item:ScraperItem) {
        if self.year.value == 0 {
            self.newYear(item:item)
        } else if self.year.value == item.year {
            self.year.contributions += item.count
        } else {
            self.storeYear()
            self.newYear(item:item)
        }
    }
    
    private func evaluateMonth(item:ScraperItem) {
        if self.month.value != item.month {
            self.storeMonth()
            self.newMonth(item:item)
        }
        self.month.contributions += item.count
    }
    
    private func storeYear() {
        if self.year.contributions > self.maxYear {
            self.maxYear = self.year.contributions
        }
        self.storeMonth()
        self.items.append(self.year)
    }
    
    private func newYear(item:ScraperItem) {
        self.year = Year()
        self.year.value = item.year
        self.year.contributions += item.count
        self.newMonth(item:item)
    }
    
    private func newMonth(item:ScraperItem) {
        self.month = Month()
        self.month.value = item.month
    }
    
    private func storeMonth() {
        if self.month.contributions > self.maxMonth {
            self.maxMonth = self.month.contributions
        }
        self.year.months.append(self.month)
    }
}
