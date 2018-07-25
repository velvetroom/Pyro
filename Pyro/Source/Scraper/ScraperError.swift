import Foundation

struct ScraperError:LocalizedError {
    let errorDescription:String?
    
    static let dateInTheFuture:ScraperError = ScraperError(errorDescription:NSLocalizedString(
        "ScraperError.dateInTheFuture", tableName:nil, bundle:Bundle(for:Scraper.self), comment:String()))
}
