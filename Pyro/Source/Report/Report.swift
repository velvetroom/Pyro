import Foundation

class Report:ReportProtocol, LoadDelegate {
    weak var delegate:ReportDelegate?
    var load:LoadProtocol
    var builder:MetricsBuilderProtocol
    weak var user:User_v1?
    private let dispatch:DispatchQueue
    
    init() {
        self.load = Load()
        self.builder = MetricsBuilder()
        self.dispatch = DispatchQueue(label:Constants.identifier, qos:DispatchQoS.background,
                                      attributes:DispatchQueue.Attributes.concurrent,
                                      autoreleaseFrequency:DispatchQueue.AutoreleaseFrequency.inherit,
                                      target:DispatchQueue.global(qos:DispatchQoS.QoSClass.background))
        self.load.delegate = self
    }
    
    func make(user:User_v1) {
        self.user = user
        self.dispatch.async { [weak self] in
            self?.load.start(user:user)
        }
    }
    
    func load(progress:Float) {
        DispatchQueue.main.async { [weak self] in
            self?.delegate?.report(progress:progress)
        }
    }
    
    func loadCompleted(items:[ScraperItem]) {
        self.user?.metrics = self.builder.build(items:items)
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

private struct Constants {
    static let identifier:String = "pyro.report"
}
