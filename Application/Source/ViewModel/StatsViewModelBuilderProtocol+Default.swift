import Foundation

extension StatsViewModelBuilderProtocol {
    mutating func build() {
        self.makeStatus()
        self.makeFirstContribution()
        self.makeLastContribution()
        self.makeContributions()
        self.makeMaxStreak()
        self.makeCurrentStreak()
    }
    
    private mutating func makeStatus() {
        var item:StatsViewModelItem = StatsViewModelItem()
        item.name = NSLocalizedString("StatsViewModelItem_Status", comment:String())
        item.value = self.status
        self.viewModel.items.append(item)
    }
    
    private mutating func makeFirstContribution() {
        var item:StatsViewModelItem = StatsViewModelItem()
        item.name = NSLocalizedString("StatsViewModelItem_FirstContribution", comment:String())
        item.value = self.firstContribution
        self.viewModel.items.append(item)
    }
    
    private mutating func makeLastContribution() {
        var item:StatsViewModelItem = StatsViewModelItem()
        item.name = NSLocalizedString("StatsViewModelItem_LastContribution", comment:String())
        item.value = self.lastContribution
        self.viewModel.items.append(item)
    }
    
    private mutating func makeContributions() {
        var item:StatsViewModelItem = StatsViewModelItem()
        item.name = NSLocalizedString("StatsViewModelItem_Contributions", comment:String())
        item.value = self.contributions
        self.viewModel.items.append(item)
    }
    
    private mutating func makeMaxStreak() {
        var item:StatsViewModelItem = StatsViewModelItem()
        item.name = NSLocalizedString("StatsViewModelItem_MaxStreak", comment:String())
        item.value = self.maxStreak
        self.viewModel.items.append(item)
    }
    
    private mutating func makeCurrentStreak() {
        var item:StatsViewModelItem = StatsViewModelItem()
        item.name = NSLocalizedString("StatsViewModelItem_CurrentStreak", comment:String())
        item.value = self.currentStreak
        self.viewModel.items.append(item)
    }
}
