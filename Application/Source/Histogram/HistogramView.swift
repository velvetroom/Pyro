import UIKit

class HistogramView:UIView {
    weak var background:HistograBackgroundView!
    var months:[HistogramMonthView]
    
    init() {
        self.months = []
        super.init(frame:CGRect.zero)
        self.isUserInteractionEnabled = false
        self.translatesAutoresizingMaskIntoConstraints = false
        self.makeOutlets()
        self.layoutOutlets()
    }
    
    required init?(coder:NSCoder) { return nil }
    override var intrinsicContentSize:CGSize { get { return CGSize(width:UIView.noIntrinsicMetric,
                                                                   height:Constants.height) } }
    
    func update(items:[StatsItemMonth]) {
        for index:Int in 0 ..< self.months.count {
            let month:HistogramMonthView = self.months[index]
            if index < items.count {
                month.update(amount:Constants.height * items[index].ratio)
                month.contributions = items[index].contributions
            } else {
                month.update(amount:0)
                month.contributions = NSAttributedString()
            }
        }
    }
    
    private func makeOutlets() {
        self.makeBackground()
        self.makeMonths()
    }
    
    private func layoutOutlets() {
        self.layoutBackground()
    }
    
    private func makeBackground() {
        let background:HistograBackgroundView = HistograBackgroundView()
        self.background = background
        self.addSubview(background)
    }
    
    private func makeMonths() {
        var anchor:NSLayoutXAxisAnchor = self.leftAnchor
        for _:Int in 0 ..< Constants.months {
            let month:HistogramMonthView = HistogramMonthView()
            self.months.append(month)
            self.addSubview(month)
            self.layout(month:month, anchor:anchor)
            anchor = month.rightAnchor
        }
    }
    
    private func layoutBackground() {
        self.background.topAnchor.constraint(equalTo:self.topAnchor).isActive = true
        self.background.bottomAnchor.constraint(equalTo:self.bottomAnchor).isActive = true
        self.background.leftAnchor.constraint(equalTo:self.leftAnchor).isActive = true
        self.background.rightAnchor.constraint(equalTo:self.rightAnchor).isActive = true
    }
    
    private func layout(month:HistogramMonthView, anchor:NSLayoutXAxisAnchor) {
        month.leftAnchor.constraint(equalTo:anchor).isActive = true
        month.bottomAnchor.constraint(equalTo:self.bottomAnchor).isActive = true
        month.topAnchor.constraint(equalTo:self.topAnchor).isActive = true
        month.widthAnchor.constraint(equalTo:self.widthAnchor,
                                     multiplier:Constants.monthWidthMultiplier).isActive = true
    }
}

private struct Constants {
    static let height:CGFloat = 300
    static let months:Int = 12
    static let monthWidthMultiplier:CGFloat = 1.0 / CGFloat(Constants.months)
}
