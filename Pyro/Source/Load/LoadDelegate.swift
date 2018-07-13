import Foundation

protocol LoadDelegate:AnyObject {
    func loadCompleted(items:[ScraperItem])
    func loadFailed(error:Error)
}
