import Foundation

class Report:LoadDelegate {
    weak var delegate:ReportDelegate?
    var load:LoadProtocol
    var builder:StatsBuilderProtocol
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
        self.dispatch.async { [weak self] in
            self?.load.start(user:user)
        }
    }
    
    func loadCompleted(items:[ScraperItem]) {
        let stats:Stats = self.builder.build(items:items)
        self.completed(stats:stats)
    }
    
    func loadFailed(error:Error) {
        DispatchQueue.main.async { [weak self] in
            self?.delegate?.reportFailed(error:error)
        }
    }
    
    private func completed(stats:Stats) {
        DispatchQueue.main.async { [weak self] in
            self?.delegate?.reportCompleted(stats:stats)
        }
    }
}
