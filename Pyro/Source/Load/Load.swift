import Foundation

class Load:LoadProtocol {
    weak var delegate:LoadDelegate?
    var request:RequestProtocol
    var scraper:ScraperProtocol
    var cleaner:ScraperCleanerProtocol
    private var user:User!
    private var items:[ScraperItem]
    
    init() {
        self.request = Request()
        self.scraper = Scraper()
        self.cleaner = ScraperCleaner()
        self.items = []
    }
    
    func start(user:User) {
        self.user = user
        self.next(year:LoadConstants.startingYear)
    }
    
    private func next(year:Int) {
        if year <= LoadConstants.endingYear {
            self.load(year:year)
        } else {
            self.delegate?.loadCompleted(items:self.items)
        }
    }
    
    private func load(year:Int) {
        self.request.make(user:self.user, year:year, onCompletion: { [weak self] (data:Data) in
            self?.completed(year:year, data:data)
        }, onError: { [weak self] (error:Error) in
            self?.delegate?.loadFailed(error:error)
        })
    }
    
    private func completed(year:Int, data:Data) {
        let uncleanItems:[ScraperItem] = self.scraper.makeItems(data:data)
        let items:[ScraperItem] = self.cleaner.clean(year:year - 1, items:uncleanItems)
        self.items.append(contentsOf:items)
        self.next(year:year + 1)
    }
}
