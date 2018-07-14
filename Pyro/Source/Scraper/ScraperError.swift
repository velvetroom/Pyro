import Foundation

struct ScraperError:LocalizedError {
    let errorDescription:String?
    
    static let dateInTheFuture:ScraperError = ScraperError(errorDescription:NSLocalizedString(
        "ScraperError_dateInTheFuture", tableName:nil, bundle:Bundle(for:Scraper.self), comment:String()))
}
