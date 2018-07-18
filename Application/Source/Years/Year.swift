import Foundation

struct Year {
    var months:[Month]
    var value:Int
    
    init() {
        self.months = []
        self.value = 0
    }
}
