import Foundation
@testable import Pyro

class MockProfilerProtocol:ProfilerProtocol {
    var onLoad:(() -> Void)?
    weak var delegate:ProfilerDelegate?
    
    func load(url:String) {
        self.onLoad?()
    }
}
