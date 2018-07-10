import Foundation

protocol StatsViewModelBuilderProtocol {
    var viewModel:StatsViewModel { get set }
    var status:String { get }
    var firstContribution:String { get }
    var lastContribution:String { get }
    var contributions:String { get }
    var maxStreak:String { get }
    var currentStreak:String { get }
}
