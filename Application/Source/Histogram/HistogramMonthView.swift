import UIKit

class HistogramMonthView:UIView {
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
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func makeOutlets() {
    }
    
    private func layoutOutlets() {
    }
}

private struct Constants {
    static let fontSize:CGFloat = 10
    static let nameBottom:CGFloat = -5
}
