import Foundation

protocol ScraperProtocol {
    func makeItems(data:Data) -> [ScraperItem]
}
