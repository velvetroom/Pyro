import Foundation

class Load:LoadProtocol {
    weak var delegate:LoadDelegate?
    var request:RequestProtocol
    var scraper:ScraperProtocol
    private var user:User!
    
    init() {
        self.request = Request()
        self.scraper = Scraper()
    }
    
    func start(user:User) {
        self.user = user
        self.next(year:Constants.startingYear)
    }
    
    private func next(year:Int) {
        if year <= Constants.endingYear {
            self.load(year:year)
        } else {
            self.finished()
        }
    }
    
    private func load(year:Int) {
        self.request.make(user:self.user, year:year, onCompletion: { [weak self] (data:Data) in
            do {
                try self?.scraper.makeItems(data:data)
            } catch {
                self?.finished()
                return
            }
            self?.next(year:year + 1)
        }, onError: { [weak self] (error:Error) in
            self?.delegate?.loadFailed(error:error)
        })
    }
    
    private func finished() {
        self.delegate?.loadCompleted(items:self.scraper.items)
    }
}

private struct Constants {
    static let startingYear:Int = 2007
    static let endingYear:Int = 2020
}
