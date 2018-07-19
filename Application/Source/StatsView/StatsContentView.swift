import UIKit

class StatsContentView:UIView {
    weak var metrics:StatsMetricsTouchView!
    weak var needsSync:StatsNeedsSyncView!
    weak var loading:LoadingView!
    
    init() {
        super.init(frame:CGRect.zero)
        self.backgroundColor = UIColor.white
        self.makeOutlets()
        self.layoutOutlets()
    }
    
    required init?(coder:NSCoder) { return nil }
    
    private func makeOutlets() {
        self.makeMetrics()
        self.makeNeedsSync()
        self.makeLoading()
    }
    
    private func layoutOutlets() {
        self.layoutMetrics()
        self.layoutNeedsSync()
        self.layoutLoading()
    }
    
    private func makeMetrics() {
        let metrics:StatsMetricsTouchView = StatsMetricsTouchView()
        self.metrics = metrics
        self.addSubview(metrics)
    }
    
    private func makeNeedsSync() {
        let needsSync:StatsNeedsSyncView = StatsNeedsSyncView()
        self.needsSync = needsSync
        self.addSubview(needsSync)
    }
    
    private func makeLoading() {
        let loading:LoadingView = LoadingView()
        loading.tintColor = UIColor.black
        self.loading = loading
        self.addSubview(loading)
    }
    
    private func layoutMetrics() {
        self.metrics.topAnchor.constraint(equalTo:self.topAnchor).isActive = true
        self.metrics.bottomAnchor.constraint(equalTo:self.bottomAnchor).isActive = true
        self.metrics.leftAnchor.constraint(equalTo:self.leftAnchor).isActive = true
        self.metrics.rightAnchor.constraint(equalTo:self.rightAnchor).isActive = true
    }
    
    private func layoutNeedsSync() {
        self.needsSync.topAnchor.constraint(equalTo:self.topAnchor).isActive = true
        self.needsSync.bottomAnchor.constraint(equalTo:self.bottomAnchor).isActive = true
        self.needsSync.leftAnchor.constraint(equalTo:self.leftAnchor).isActive = true
        self.needsSync.rightAnchor.constraint(equalTo:self.rightAnchor).isActive = true
    }
    
    private func layoutLoading() {
        self.loading.centerXAnchor.constraint(equalTo:self.centerXAnchor).isActive = true
        self.loading.centerYAnchor.constraint(equalTo:self.centerYAnchor).isActive = true
    }
}
