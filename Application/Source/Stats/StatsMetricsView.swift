import UIKit

class StatsMetricsView:UIView {
    weak var month:StatsHistogramMonthView?
    weak var years:UICollectionView!
    weak var histogram:StatsHistogramView!
    weak var detail:UILabel!
    weak var streak:UILabel!
    weak var contributions:UILabel!
    weak var border:UIView!
    
    init() {
        super.init(frame:CGRect.zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.makeOutlets()
        self.layoutOutlets()
    }
    
    required init?(coder:NSCoder) { return nil }
    override func touchesBegan(_ touches:Set<UITouch>, with:UIEvent?) { self.touching(touch:touches.first!) }
    override func touchesMoved(_ touches:Set<UITouch>, with:UIEvent?) { self.touching(touch:touches.first!) }
    override func touchesEnded(_:Set<UITouch>, with:UIEvent?) { self.touchEnded() }
    override func touchesCancelled(_:Set<UITouch>, with:UIEvent?) { self.touchEnded() }
    
    private func makeOutlets() {
        let border:UIView = UIView()
        border.backgroundColor = UIColor(white:0, alpha:0.1)
        border.translatesAutoresizingMaskIntoConstraints = false
        border.isUserInteractionEnabled = false
        self.border = border
        self.addSubview(border)
        
        let histogram:StatsHistogramView = StatsHistogramView()
        self.histogram = histogram
        self.addSubview(histogram)
        
        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flow.scrollDirection = UICollectionView.ScrollDirection.horizontal
        flow.minimumInteritemSpacing = 0
        flow.minimumLineSpacing = 0
        flow.headerReferenceSize = CGSize.zero
        flow.footerReferenceSize = CGSize.zero
        flow.itemSize = CGSize(width:StatsMetricsCellView.width, height:Constants.yearsHeight)
        
        let years:UICollectionView = UICollectionView(frame:CGRect.zero, collectionViewLayout:flow)
        years.backgroundColor = UIColor.clear
        years.translatesAutoresizingMaskIntoConstraints = false
        years.clipsToBounds = true
        years.showsVerticalScrollIndicator = false
        years.showsHorizontalScrollIndicator = false
        years.alwaysBounceVertical = false
        years.alwaysBounceHorizontal = true
        self.years = years
        self.addSubview(years)
        
        let streak:UILabel = UILabel()
        streak.translatesAutoresizingMaskIntoConstraints = false
        streak.numberOfLines = 0
        self.streak = streak
        self.addSubview(streak)
        
        let contributions:UILabel = UILabel()
        contributions.translatesAutoresizingMaskIntoConstraints = false
        contributions.numberOfLines = 0
        contributions.textAlignment = NSTextAlignment.right
        self.contributions = contributions
        self.addSubview(contributions)
        
        let detail:UILabel = UILabel()
        detail.isUserInteractionEnabled = false
        detail.translatesAutoresizingMaskIntoConstraints = false
        detail.numberOfLines = 0
        self.detail = detail
        self.addSubview(detail)
    }
    
    private func layoutOutlets() {
        self.histogram.topAnchor.constraint(equalTo:self.detail.topAnchor).isActive = true
        self.histogram.leftAnchor.constraint(equalTo:self.leftAnchor).isActive = true
        self.histogram.rightAnchor.constraint(equalTo:self.rightAnchor).isActive = true
        
        self.streak.leftAnchor.constraint(equalTo:self.leftAnchor, constant:Constants.margin).isActive = true
        self.streak.widthAnchor.constraint(greaterThanOrEqualToConstant:0).isActive = true
        self.streak.heightAnchor.constraint(greaterThanOrEqualToConstant:0).isActive = true
        
        self.contributions.rightAnchor.constraint(equalTo:self.rightAnchor, constant:-Constants.margin).isActive = true
        self.contributions.widthAnchor.constraint(greaterThanOrEqualToConstant:0).isActive = true
        self.contributions.heightAnchor.constraint(greaterThanOrEqualToConstant:0).isActive = true
        
        self.years.topAnchor.constraint(equalTo:self.streak.bottomAnchor).isActive = true
        self.years.leftAnchor.constraint(equalTo:self.leftAnchor).isActive = true
        self.years.rightAnchor.constraint(equalTo:self.rightAnchor).isActive = true
        self.years.heightAnchor.constraint(equalToConstant:Constants.yearsHeight).isActive = true
        
        self.detail.topAnchor.constraint(equalTo:self.years.bottomAnchor, constant:Constants.detailTop).isActive = true
        self.detail.leftAnchor.constraint(equalTo:self.leftAnchor, constant:Constants.margin).isActive = true
        self.detail.rightAnchor.constraint(equalTo:self.rightAnchor, constant:-Constants.margin).isActive = true
        self.detail.heightAnchor.constraint(greaterThanOrEqualToConstant:0).isActive = true
        
        self.border.leftAnchor.constraint(equalTo:self.leftAnchor).isActive = true
        self.border.rightAnchor.constraint(equalTo:self.rightAnchor).isActive = true
        self.border.bottomAnchor.constraint(equalTo:self.years.bottomAnchor,
                                            constant:Constants.borderBottom).isActive = true
        self.border.heightAnchor.constraint(equalToConstant:Constants.border).isActive = true
        
        if #available(iOS 11.0, *) {
            self.histogram.bottomAnchor.constraint(equalTo:self.safeAreaLayoutGuide.bottomAnchor).isActive = true
            self.streak.bottomAnchor.constraint(equalTo:self.safeAreaLayoutGuide.topAnchor,
                                                constant:Constants.streakHeight).isActive = true
            self.contributions.bottomAnchor.constraint(equalTo:self.safeAreaLayoutGuide.topAnchor,
                                                       constant:Constants.streakHeight).isActive = true
        } else {
            self.histogram.bottomAnchor.constraint(equalTo:self.bottomAnchor).isActive = true
            self.streak.bottomAnchor.constraint(equalTo:self.topAnchor, constant:Constants.streakHeight).isActive = true
            self.contributions.bottomAnchor.constraint(equalTo:self.topAnchor,
                                                       constant:Constants.streakHeight).isActive = true
        }
    }
    
    private func touching(touch:UITouch) {
        guard
            let month:StatsHistogramMonthView = self.monthAt(touch:touch)
        else {
            self.touchEnded()
            return
        }
        if month !== self.month {
            self.update(month:month)
        }
    }
    
    private func touchEnded() {
        self.detail.attributedText = NSAttributedString()
        self.month?.unhighlight()
        self.month = nil
    }
    
    private func monthAt(touch:UITouch) -> StatsHistogramMonthView? {
        let position:CGPoint = touch.location(in:self.histogram)
        for month:StatsHistogramMonthView in self.histogram.months {
            if month.frame.contains(position) {
                return month
            }
        }
        return nil
    }
    
    private func update(month:StatsHistogramMonthView) {
        month.highlight()
        self.detail.attributedText = month.contributions
        self.month?.unhighlight()
        self.month = month
    }
}

private struct Constants {
    static let border:CGFloat = 1
    static let borderBottom:CGFloat = -27
    static let yearsHeight:CGFloat = 80
    static let streakHeight:CGFloat = 92
    static let detailTop:CGFloat = -20
    static let margin:CGFloat = 10
}
