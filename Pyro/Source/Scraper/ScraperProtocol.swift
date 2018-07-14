import Foundation

protocol ScraperProtocol {
    var items:[ScraperItem] { get }
    
    func makeItems(data:Data) throws
}
