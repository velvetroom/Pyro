import UIKit

class StatsHistogramView:UIView {
    var months:[StatsHistogramMonthView]
    
    init() {
        self.months = []
        super.init(frame:CGRect.zero)
        self.isUserInteractionEnabled = false
        self.translatesAutoresizingMaskIntoConstraints = false
        self.makeOutlets()
    }
    
    required init?(coder:NSCoder) { return nil }
    
    func update(items:[StatsItemMonth]) {
        for index:Int in 0 ..< self.months.count {
            let month:StatsHistogramMonthView = self.months[index]
            if index < items.count {
                month.update(amount:items[index].ratio)
                month.contributions = items[index].contributions
            } else {
                month.update(amount:0)
                month.contributions = NSAttributedString()
            }
        }
    }
    
    private func makeOutlets() {
        var anchor:NSLayoutXAxisAnchor = self.leftAnchor
        for _:Int in 0 ..< Constants.months {
            let month:StatsHistogramMonthView = StatsHistogramMonthView()
            self.months.append(month)
            self.addSubview(month)
            
            month.leftAnchor.constraint(equalTo:anchor).isActive = true
            month.bottomAnchor.constraint(equalTo:self.bottomAnchor).isActive = true
            month.topAnchor.constraint(equalTo:self.topAnchor).isActive = true
            month.widthAnchor.constraint(equalTo:self.widthAnchor,
                                         multiplier:Constants.monthWidthMultiplier).isActive = true
            anchor = month.rightAnchor
        }
    }
}

private struct Constants {
    static let months:Int = 12
    static let monthWidthMultiplier:CGFloat = 1.0 / CGFloat(Constants.months)
}
