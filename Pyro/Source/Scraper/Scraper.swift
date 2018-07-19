import Foundation

class Scraper:ScraperProtocol {
    var items:[ScraperItem] { get { return self.repository.items } }
    var repository:ScraperItems
    private let today:Date
    private let dateFormatter:DateFormatter
    
    init() {
        self.repository = ScraperItems()
        self.today = Date()
        self.dateFormatter = DateFormatter()
        self.dateFormatter.dateFormat = MetricsConstants.dateFormat
    }
    
    func makeItems(data:Data) throws {
        let string:String = String(data:data, encoding:String.Encoding.utf8)!
        let items:[String] = self.makeComponents(string:string)
        for item:String in items {
            let components:[String] = item.components(separatedBy:Constants.prefixDate)
            try self.makeItemWith(components:components)
        }
    }
    
    private func makeComponents(string:String) -> [String] {
        var components:[String] = string.components(separatedBy:Constants.prefixCount)
        if components.count > 0 {
            components.removeFirst()
        }
        return components
    }
    
    private func makeItemWith(components:[String]) throws {
        let date:String = self.date(components:components)
        if try self.valid(date:date) {
            var item:ScraperItem = ScraperItem()
            item.date = date
            item.count = self.count(components:components)
            item.year = self.year(date:date)
            item.month = self.month(date:date)
            self.repository.checklist[date] = true
            self.repository.items.append(item)
        }
    }
    
    private func date(components:[String]) -> String  {
        return String(components[1].prefix(Constants.dateLength))
    }
    
    private func valid(date:String) throws -> Bool {
        if self.repository.checklist[date] == nil {
            guard
                let itemDate:Date = dateFormatter.date(from:date),
                itemDate <= self.today
            else { throw ScraperError.dateInTheFuture }
            return true
        }
        return false
    }
    
    private func count(components:[String]) -> Int {
        guard
            let countString:String = components.first,
            let countInt:Int = Int(countString)
        else { return 0 }
        return countInt
    }
    
    private func year(date:String) -> Int {
        guard
            let yearString:String = date.components(separatedBy:Constants.dateSeparator).first,
            let year:Int = Int(yearString)
        else { return 0 }
        return year
    }
    
    private func month(date:String) -> Int {
        let components:[String] = date.components(separatedBy:Constants.dateSeparator)
        guard
            components.count > 1,
            let month:Int = Int(components[1])
        else { return 0 }
        return month
    }
}

private struct Constants {
    static let prefixCount:String = "data-count=\""
    static let prefixDate:String = "\" data-date=\""
    static let dateSeparator:String = "-"
    static let dateLength:Int = 10
}
