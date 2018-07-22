import Foundation
import CleanArchitecture
import Pyro
import StoreKit

class StatsInteractor:InteractorProtocol, PyroDelegate {
    weak var router:Router?
    weak var presenter:InteractorDelegate?
    weak var pyro:Pyro!
    weak var user:User!
    var error:Error?
    
    required init() { }
    
    func synchStats() {
        self.pyro.delegate = self
        self.pyro.makeReport(user:self.user)
    }
    
    func delete() {
        self.pyro.delete(user:self.user)
        self.router?.popViewController(animated:true)
    }
    
    func pyroUpdated() {
        self.error = nil
        self.presenter?.shouldUpdate()
    }
    
    func pyroFailed(error:Error) {
        self.error = error
        self.presenter?.shouldUpdate()
    }
    
    func didLoad() {
        if self.pyro.shouldRate() {
            if #available(iOS 10.3, *) {
                SKStoreReviewController.requestReview()
            }
        }
    }
}
