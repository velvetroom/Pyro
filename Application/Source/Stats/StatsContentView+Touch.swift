import UIKit

extension StatsContentView {
    func touching(touch:UITouch) {
        guard
            let month:HistogramMonthView = self.monthAt(touch:touch)
        else {
            self.touchEnded()
            return
        }
        if month !== self.month {
            month.highlight()
            self.detail.label.attributedText = month.contributions
            self.month?.unhighlight()
            self.month = month
        }
    }
    
    func touchEnded() {
        self.month?.unhighlight()
    }
    
    private func monthAt(touch:UITouch) -> HistogramMonthView? {
        let position:CGPoint = touch.location(in:self.histogram)
        for month:HistogramMonthView in self.histogram.months {
            if month.frame.contains(position) {
                return month
            }
        }
        return nil
    }
}
