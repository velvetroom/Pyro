import Foundation

protocol LoadDelegate:AnyObject {
    func load(progress:Float)
    func loadCompleted(items:[ScraperItem])
    func loadFailed(error:Error)
}
