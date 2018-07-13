import Foundation
import CleanArchitecture
import Pyro

class StatsInteractor:InteractorProtocol, ReportDelegate {
    weak var transition:Navigation?
    weak var presenter:InteractorDelegateProtocol?
    var user:User
    var stats:Stats?
    var error:Error?
    private var report:ReportProtocol
    
    required init() {
        self.user = User()
        self.report = Factory.makeReport()
        self.report.delegate = self
    }
    
    func generateReport() {
        self.report.make(user:user)
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
