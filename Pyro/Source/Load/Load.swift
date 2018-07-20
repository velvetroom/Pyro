import Foundation

class Load:LoadProtocol {
    weak var delegate:LoadDelegate?
    var scraper:ScraperProtocol?
    var request:RequestProtocol
    var user:User!
    
    init() {
        self.request = Request()
    }
    
    func start(user:User) {
        self.user = user
        self.scraper = Scraper()
        self.next(year:Constants.startingYear)
    }
    
    func next(year:Int) {
        if year <= Constants.endingYear {
            self.load(year:year)
        } else {
            self.finished()
        }
    }
    
    private func load(year:Int) {
        self.request.make(user:self.user, year:year, onCompletion: { [weak self] (data:Data) in
            do {
                try self?.scraper?.makeItems(data:data)
            } catch {
                self?.finished()
                return
            }
            self?.next(year:year + 1)
        }, onError: { [weak self] (error:Error) in
            self?.scraper = nil
            self?.delegate?.loadFailed(error:error)
        })
    }
    
    private func finished() {
        if let items:[ScraperItem] = self.scraper?.items {
            self.delegate?.loadCompleted(items:items)
        }
        self.scraper = nil
    }
}

private struct Constants {
    static let startingYear:Int = 1999
    static let endingYear:Int = 2020
}
