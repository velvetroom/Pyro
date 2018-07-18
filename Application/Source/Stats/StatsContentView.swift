import UIKit

class StatsContentView:UIView {
    weak var amount:StatsAmountView!
    weak var years:YearsView!
    weak var histogram:HistogramView!
    
    init() {
        super.init(frame:CGRect.zero)
        self.configureView()
        self.makeOutlets()
        self.layoutOutlets()
    }
    
    required init?(coder:NSCoder) {
        return nil
    }
    
    private func configureView() {
        self.backgroundColor = UIColor.white
    }
    
    private func makeOutlets() {
        self.makeHistogram()
        self.makeYears()
        self.makeAmount()
    }
    
    private func layoutOutlets() {
        self.layoutHistogram()
        self.layoutAmount()
        self.layoutYears()
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
    
    private func layoutAmount() {
        self.amount.leftAnchor.constraint(equalTo:self.leftAnchor).isActive = true
        self.amount.rightAnchor.constraint(equalTo:self.rightAnchor).isActive = true
        self.amount.heightAnchor.constraint(equalToConstant:Constants.amountHeight).isActive = true
        if #available(iOS 11.0, *) {
            self.amount.topAnchor.constraint(equalTo:self.safeAreaLayoutGuide.topAnchor).isActive = true
        } else {
            self.amount.topAnchor.constraint(equalTo:self.topAnchor).isActive = true
        }
    }
    
    private func layoutHistogram() {
        self.histogram.leftAnchor.constraint(equalTo:self.leftAnchor).isActive = true
        self.histogram.rightAnchor.constraint(equalTo:self.rightAnchor).isActive = true
        self.histogram.heightAnchor.constraint(equalToConstant:Constants.histogramHeight).isActive = true
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
        self.years.heightAnchor.constraint(equalToConstant:Constants.yearsHeight).isActive = true
    }
}

private struct Constants {
    static let amountHeight:CGFloat = 110
    static let histogramHeight:CGFloat = 300
    static let yearsHeight:CGFloat = 60
}
