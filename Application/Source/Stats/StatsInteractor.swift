import Foundation
import CleanArchitecture
import Pyro
import StoreKit

class StatsInteractor:InteractorProtocol, PyroDelegate {
    weak var router:Router?
    weak var presenter:InteractorDelegate?
    weak var pyro:Pyro!
    weak var user:UserProtocol!
    var state:StatsStateProtocol
    
    required init() {
        self.state = StatsStateNeedsSync()
    }
    
    func checkState() {
        if let metrics:Metrics = self.user.metrics {
            self.state = StatsStateReady(metrics:metrics)
        } else {
            self.state = StatsStateNeedsSync()
        }
    }
    
    func synchStats() {
        self.pyro.delegate = self
        self.pyro.makeReport(user:self.user)
    }
    
    func delete() {
        self.pyro.delete(user:self.user)
        self.router?.popViewController(animated:true)
    }
    
    func pyroReport(progress:Float) {
        self.state = StatsStateLoading(progress:progress)
        self.presenter?.shouldUpdate()
    }
    
    func pyroUpdated() {
        self.checkState()
        self.presenter?.shouldUpdate()
    }
    
    func pyroFailed(error:Error) {
        self.state = StatsStateError(error:error)
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
