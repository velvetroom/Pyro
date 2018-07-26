import Foundation
@testable import Pyro

class MockProfilerProtocol:ProfilerProtocol {
    var onLoad:(() -> Void)?
    var error:Error?
    weak var delegate:ProfilerDelegate?
    
    func load(url:String) {
        self.onLoad?()
        if let error:Error = self.error {
            self.delegate?.profileFailed(error:error)
        } else {
            self.delegate?.profileLoaded(profile:Profile())
        }
    }
}
