import Foundation

class Scraper:ScraperProtocol {
    var items:[ScraperItem] { get { return self.repository.items } }
    var repository:ScraperItems
    
    init() {
        self.repository = ScraperItems()
    }
    
    func makeItems(data:Data) {
        let string:String = String(data:data, encoding:String.Encoding.utf8)!
        self.makeItems(string:string)
    }
    
    private func makeItems(string:String) {
        let items:[String] = self.makeComponents(string:string)
        for item:String in items {
            let components:[String] = item.components(separatedBy:ScraperConstants.prefixDate)
            self.makeItemWith(components:components)
        }
    }
    
    private func makeComponents(string:String) -> [String] {
        var components:[String] = string.components(separatedBy:ScraperConstants.prefixCount)
        if components.count > 0 {
            components.removeFirst()
        }
        return components
    }
    
    private func makeItemWith(components:[String]) {
        let date:String = self.date(components:components)
        if self.repository.checklist[date] == nil {
            var item:ScraperItem = ScraperItem()
            item.date = date
            item.count = self.count(components:components)
            self.repository.checklist[date] = true
            self.repository.items.append(item)
        }
    }
    
    private func date(components:[String]) -> String  {
        return String(components[1].prefix(ScraperConstants.dateLength))
    }
    
    private func count(components:[String]) -> Int {
        guard
            let countString:String = components.first,
            let countInt:Int = Int(countString)
        else { return 0 }
        return countInt
    }
}
