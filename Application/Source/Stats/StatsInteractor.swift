import Foundation
import CleanArchitecture
import Pyro
import StoreKit

class StatsInteractor:Interactor, PyroDelegate {
    weak var delegate:InteractorDelegate?
    weak var pyro:Pyro!
    weak var user:UserProtocol!
    var state:StatsStateProtocol
    
    required init() {
        self.state = StatsStateNeedsSync()
    }
    
    func checkState() {
        if self.user.metrics == nil {
            self.state = StatsStateNeedsSync()
        } else {
            self.state = StatsStateReady(user:self.user)
        }
    }
    
    func synchStats() {
        self.pyro.delegate = self
        self.pyro.loadProfile(url:self.user.url)
        self.state = StatsStateLoading(progress:0)
        self.delegate?.shouldUpdate()
    }
    
    func delete() {
        self.pyro.delete(user:self.user)
    }
    
    func pyroReportReady() {
        self.checkState()
        self.delegate?.shouldUpdate()
    }
    
    func pyroReport(progress:Float) {
        self.state = StatsStateLoading(progress:progress)
        self.delegate?.shouldUpdate()
    }
    
    func pyroLoaded(profile:Profile) {
        self.user.user = profile.user
        self.user.name = profile.name
        self.user.bio = profile.bio
        self.pyro.makeReport(user:self.user)
    }
    
    func pyroFailed(error:Error) {
        self.state = StatsStateError(error:error)
        self.delegate?.shouldUpdate()
    }
    
    func didLoad() {
        if self.pyro.shouldRate() { if #available(iOS 10.3, *) { SKStoreReviewController.requestReview() } }
    }
}
