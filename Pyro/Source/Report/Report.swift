import Foundation

class Report:ReportProtocol, LoadDelegate {
    weak var delegate:ReportDelegate?
    var load:LoadProtocol
    var builder:StatsBuilderProtocol
    weak var user:User?
    private let dispatch:DispatchQueue
    
    init() {
        self.load = Load()
        self.builder = StatsBuilder()
        self.dispatch = DispatchQueue(label:ReportConstants.identifier, qos:DispatchQoS.background,
                                      attributes:DispatchQueue.Attributes.concurrent,
                                      autoreleaseFrequency:DispatchQueue.AutoreleaseFrequency.inherit,
                                      target:DispatchQueue.global(qos:DispatchQoS.QoSClass.background))
        self.load.delegate = self
    }
    
    func make(user:User) {
        self.user = user
        self.dispatch.async { [weak self] in
            self?.load.start(user:user)
        }
    }
    
    func loadCompleted(items:[ScraperItem]) {
        self.user?.stats = self.builder.build(items:items)
        DispatchQueue.main.async { [weak self] in
            self?.delegate?.reportCompleted()
        }
    }
    
    func loadFailed(error:Error) {
        DispatchQueue.main.async { [weak self] in
            self?.delegate?.reportFailed(error:error)
        }
    }
}
