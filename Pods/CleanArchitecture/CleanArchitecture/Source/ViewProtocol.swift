import Foundation

public protocol ViewProtocol:AnyObject {
    var interactor:InteractorProtocol { get }
    var viewModel:ViewModel { get }
    
    init()
}
