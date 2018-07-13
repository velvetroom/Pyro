import Foundation
import CleanArchitecture
import Pyro

class StatsInteractor:InteractorProtocol {
    weak var router:Router?
    weak var presenter:InteractorDelegateProtocol?
    weak var pyro:Pyro!
    var user:User!
    var stats:Stats?
    var error:Error?
    
    required init() { }
    
    func generateReport(delegate:ReportDelegate) {
        self.pyro.makeReport(user:self.user, delegate:delegate)
    }
    
    func reportCompleted(stats:Stats) {
        self.stats = stats
        self.error = nil
        self.presenter?.shouldUpdate()
    }
    
    func reportFailed(error:Error) {
        self.stats = nil
        self.error = error
        self.presenter?.shouldUpdate()
    }
}
