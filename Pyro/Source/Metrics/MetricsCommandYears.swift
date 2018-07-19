import Foundation

class MetricsCommandYears:MetricsCommandProtocol {
    private var items:[Year]
    private var year:Year
    private var month:Month
    
    init() {
        self.items = []
        self.year = Year()
        self.month = Month()
    }
    
    func evaluate(item:ScraperItem) {
        self.evaluateYear(item:item)
        self.evaluateMonth(item:item)
    }
    
    func print(stats:inout Metrics) {
        self.year.months.append(self.month)
        self.items.append(self.year)
        stats.contributions.years = self.items
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
            self.year.months.append(month)
            self.newMonth(item:item)
        }
        self.month.contributions += item.count
    }
    
    private func storeYear() {
        self.year.months.append(self.month)
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
}
