import Foundation
@testable import Pyro

class MockProfilerDelegate:ProfilerDelegate {
    var onLoaded:((Profile) -> Void)?
    var onError:(() -> Void)?
    
    func profileLoaded(profile:Profile) {
        self.onLoaded?(profile)
    }
    
    func profileFailed(error:Error) {
        self.onError?()
    }
}
