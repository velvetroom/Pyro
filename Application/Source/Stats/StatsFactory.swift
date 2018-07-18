import Foundation

class StatsFactory {
    func makeContent() -> StatsContentViewModel {
        var property:StatsContentViewModel = StatsContentViewModel()
        property.actionsEnabled = true
        property.streak = "56"
        property.contributions = "13,456"
        return property
    }
    
    func makeYears() -> StatsYearsViewModel {
        var property:StatsYearsViewModel = StatsYearsViewModel()
        for index:Int in 0 ..< 20 {
            var year:Year = Year()
            year.value = 1998 + index
            for _:Int in 0 ..< 12 {
                var month:Month = Month()
                month.contributions = 5
                month.ratio = -1.0 / (Float(arc4random_uniform(10)) + 1.0)
                year.months.append(month)
            }
            property.items.append(year)
        }
        return property
    }
}
