import Foundation
import Pyro

class MockPyroDelegate:PyroDelegate {
    var onUpdated:(() -> Void)?
    var onError:(() -> Void)?
    
    func pyroUsersLoaded() {
        self.onUpdated?()
    }
    
    func pyroReportReady() {
        self.onUpdated?()
    }
    
    func pyroValidated() {
        self.onUpdated?()
    }
    
    func pyroReport(progress:Float) {
        self.onUpdated?()
    }
    
    func pyroLoaded(profile:Profile) {
        self.onUpdated?()
    }
    
    func pyroFailed(error:Error) {
        self.onError?()
    }
}
