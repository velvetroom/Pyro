import UIKit

class Histogram:UIView {
    var months:[HistogramMonth]
    
    init() {
        self.months = []
        super.init(frame:CGRect.zero)
        self.configureView()
        self.makeMonths()
    }
    
    required init?(coder:NSCoder) {
        return nil
    }
    
    private func configureView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
    }
    
    private func makeMonths() {
        let multiplier:CGFloat = 1.0 / CGFloat(Constants.months)
        var rightAnchor:NSLayoutXAxisAnchor = self.leftAnchor
        for _:Int in 0 ..< Constants.months {
            let month:HistogramMonth = HistogramMonth()
            self.months.append(month)
            self.addSubview(month)
            month.leftAnchor.constraint(equalTo:rightAnchor).isActive = true
            month.bottomAnchor.constraint(equalTo:self.bottomAnchor).isActive = true
            month.topAnchor.constraint(equalTo:self.topAnchor).isActive = true
            month.widthAnchor.constraint(equalTo:self.widthAnchor, multiplier:multiplier).isActive = true
            rightAnchor = month.rightAnchor
        }
    }
}

private struct Constants {
    static let months:Int = 12
}
