import UIKit

class Histogram:UIView {
    init() {
        super.init(frame:CGRect.zero)
    }
    
    required init?(coder:NSCoder) {
        return nil
    }
    
    private func configureView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
    }
}
