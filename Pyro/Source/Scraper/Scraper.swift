import Foundation

class Scraper {
    private var items:[ScraperItem]!
    private var item:ScraperItem!
    
    func makeItems(data:Data) -> [ScraperItem] {
        self.items = []
        let string:String = String(data:data, encoding:String.Encoding.utf8)!
        self.makeItems(string:string)
        return self.items
    }
    
    private func makeItems(string:String) {
        let items:[String] = self.makeComponents(string:string)
        for item:String in items {
            let components:[String] = item.components(separatedBy:ScraperConstants.prefixDate)
            self.item = ScraperItem()
            self.makeCount(components:components)
            self.makeDate(components:components)
            self.items.append(self.item)
        }
    }
    
    private func makeComponents(string:String) -> [String] {
        var items:[String] = string.components(separatedBy:ScraperConstants.prefixCount)
        if items.count > 0 {
            items.removeFirst()
        }
        return items
    }
    
    private func makeCount(components:[String]) {
        guard let countString:String = components.first else { return }
        self.item.count = Int(countString)!
    }
    
    private func makeDate(components:[String]) {
        self.item.date = String(components[1].prefix(ScraperConstants.dateLenght))
    }
}
