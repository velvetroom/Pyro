import UIKit

class StatsMetricsView:UIView {
    weak var amount:StatsAmountView!
    weak var years:YearsView!
    weak var histogram:HistogramView!
    weak var detail:StatsDetailView!
    
    init() {
        super.init(frame:CGRect.zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.makeOutlets()
        self.layoutOutlets()
    }
    
    required init?(coder:NSCoder) { return nil }
    
    private func makeOutlets() {
        self.makeHistogram()
        self.makeYears()
        self.makeAmount()
        self.makeDetail()
    }
    
    private func layoutOutlets() {
        self.layoutHistogram()
        self.layoutAmount()
        self.layoutYears()
        self.layoutDetail()
    }
    
    private func makeAmount() {
        let amount:StatsAmountView = StatsAmountView()
        self.amount = amount
        self.addSubview(amount)
    }
    
    private func makeHistogram() {
        let histogram:HistogramView = HistogramView()
        self.histogram = histogram
        self.addSubview(histogram)
    }
    
    private func makeYears() {
        let years:YearsView = YearsView()
        self.years = years
        self.addSubview(years)
    }
    
    private func makeDetail() {
        let detail:StatsDetailView = StatsDetailView()
        self.detail = detail
        self.addSubview(detail)
    }
    
    private func layoutAmount() {
        self.amount.leftAnchor.constraint(equalTo:self.leftAnchor).isActive = true
        self.amount.rightAnchor.constraint(equalTo:self.rightAnchor).isActive = true
        if #available(iOS 11.0, *) {
            self.amount.topAnchor.constraint(equalTo:self.safeAreaLayoutGuide.topAnchor).isActive = true
        } else {
            self.amount.topAnchor.constraint(equalTo:self.topAnchor).isActive = true
        }
    }
    
    private func layoutHistogram() {
        self.histogram.leftAnchor.constraint(equalTo:self.leftAnchor).isActive = true
        self.histogram.rightAnchor.constraint(equalTo:self.rightAnchor).isActive = true
        if #available(iOS 11.0, *) {
            self.histogram.bottomAnchor.constraint(equalTo:self.safeAreaLayoutGuide.bottomAnchor).isActive = true
        } else {
            self.histogram.bottomAnchor.constraint(equalTo:self.bottomAnchor).isActive = true
        }
    }
    
    private func layoutYears() {
        self.years.topAnchor.constraint(equalTo:self.amount.bottomAnchor).isActive = true
        self.years.leftAnchor.constraint(equalTo:self.leftAnchor).isActive = true
        self.years.rightAnchor.constraint(equalTo:self.rightAnchor).isActive = true
    }
    
    private func layoutDetail() {
        self.detail.topAnchor.constraint(equalTo:self.years.bottomAnchor).isActive = true
        self.detail.leftAnchor.constraint(equalTo:self.leftAnchor).isActive = true
        self.detail.rightAnchor.constraint(equalTo:self.rightAnchor).isActive = true
    }
}
