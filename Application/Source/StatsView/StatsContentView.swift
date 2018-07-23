import UIKit

class StatsContentView:UIView {
    weak var metrics:StatsMetricsTouchView!
    weak var message:StatsMessageView!
    weak var loading:LoadingView!
    weak var progress:UIProgressView!
    
    init() {
        super.init(frame:CGRect.zero)
        self.backgroundColor = UIColor.white
        self.makeOutlets()
        self.layoutOutlets()
    }
    
    required init?(coder:NSCoder) { return nil }
    
    private func makeOutlets() {
        self.makeMetrics()
        self.makeMessage()
        self.makeLoading()
        self.makeProgress()
    }
    
    private func layoutOutlets() {
        self.layoutMetrics()
        self.layoutMessage()
        self.layoutLoading()
        self.layoutProgress()
    }
    
    private func makeMetrics() {
        let metrics:StatsMetricsTouchView = StatsMetricsTouchView()
        self.metrics = metrics
        self.addSubview(metrics)
    }
    
    private func makeMessage() {
        let message:StatsMessageView = StatsMessageView()
        self.message = message
        self.addSubview(message)
    }
    
    private func makeLoading() {
        let loading:LoadingView = LoadingView()
        loading.tintColor = UIColor.black
        self.loading = loading
        self.addSubview(loading)
    }
    
    private func makeProgress() {
        let progress:UIProgressView = UIProgressView()
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.trackTintColor = UIColor(white:0, alpha:0.1)
        progress.progressTintColor = UIColor.sharedBlue
        progress.isUserInteractionEnabled = false
        self.progress = progress
        self.addSubview(progress)
    }
    
    private func layoutMetrics() {
        self.metrics.topAnchor.constraint(equalTo:self.topAnchor).isActive = true
        self.metrics.leftAnchor.constraint(equalTo:self.leftAnchor).isActive = true
        self.metrics.rightAnchor.constraint(equalTo:self.rightAnchor).isActive = true
        if #available(iOS 11.0, *) {
            self.metrics.bottomAnchor.constraint(equalTo:self.safeAreaLayoutGuide.bottomAnchor).isActive = true
        } else {
            self.metrics.bottomAnchor.constraint(equalTo:self.bottomAnchor).isActive = true
        }
    }
    
    private func layoutMessage() {
        self.message.topAnchor.constraint(equalTo:self.topAnchor).isActive = true
        self.message.bottomAnchor.constraint(equalTo:self.bottomAnchor).isActive = true
        self.message.leftAnchor.constraint(equalTo:self.leftAnchor).isActive = true
        self.message.rightAnchor.constraint(equalTo:self.rightAnchor).isActive = true
    }
    
    private func layoutLoading() {
        self.loading.centerXAnchor.constraint(equalTo:self.centerXAnchor).isActive = true
        self.loading.centerYAnchor.constraint(equalTo:self.centerYAnchor).isActive = true
    }
    
    private func layoutProgress() {
        self.progress.leftAnchor.constraint(equalTo:self.leftAnchor).isActive = true
        self.progress.rightAnchor.constraint(equalTo:self.rightAnchor).isActive = true
        if #available(iOS 11.0, *) {
            self.progress.bottomAnchor.constraint(equalTo:self.safeAreaLayoutGuide.bottomAnchor).isActive = true
        } else {
            self.progress.bottomAnchor.constraint(equalTo:self.bottomAnchor).isActive = true
        }
    }
}
