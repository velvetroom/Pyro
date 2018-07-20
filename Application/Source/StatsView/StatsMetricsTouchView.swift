import UIKit

class StatsMetricsTouchView:StatsMetricsView {
    weak var month:HistogramMonthView?
    
    override func touchesBegan(_ touches:Set<UITouch>, with:UIEvent?) { self.touching(touch:touches.first!) }
    override func touchesMoved(_ touches:Set<UITouch>, with:UIEvent?) { self.touching(touch:touches.first!) }
    override func touchesEnded(_:Set<UITouch>, with:UIEvent?) { self.touchEnded() }
    override func touchesCancelled(_:Set<UITouch>, with:UIEvent?) { self.touchEnded() }
    
    private func touching(touch:UITouch) {
        guard
            let month:HistogramMonthView = self.monthAt(touch:touch)
        else {
            self.touchEnded()
            return
        }
        if month !== self.month {
            self.update(month:month)
        }
    }
    
    private func touchEnded() {
        self.detail.label.attributedText = NSAttributedString()
        self.month?.unhighlight()
        self.month = nil
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
    
    private func update(month:HistogramMonthView) {
        month.highlight()
        self.detail.label.attributedText = month.contributions
        self.month?.unhighlight()
        self.month = month
    }
}
