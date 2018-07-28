import Foundation

public class ViewModels {
    var items:[ObjectIdentifier:Any]
    
    init() {
        self.items = [:]
    }
    
    public func update<ViewModelType:ViewModel>(viewModel:ViewModelType) {
        var item:Item<ViewModelType> = Item<ViewModelType>()
        item.viewModel = viewModel
        item.observer = self.item().observer
        self.items[ObjectIdentifier(ViewModelType.self)] = item
        DispatchQueue.main.async { item.observer?(viewModel) }
    }
    
    public func observe<ViewModelType:ViewModel>(observer:@escaping((ViewModelType) -> Void)) {
        var item:Item<ViewModelType> = self.item()
        item.observer = observer
        self.items[ObjectIdentifier(ViewModelType.self)] = item
    }
    
    private func item<ViewModelType:ViewModel>() -> Item<ViewModelType> {
        guard
            let item:Item<ViewModelType> = self.items[ObjectIdentifier(ViewModelType.self)] as? Item<ViewModelType>
        else { return Item<ViewModelType>() }
        return item
    }
}

public protocol ViewModel {
    init()
}

private struct Item<ViewModelType:ViewModel> {
    var viewModel:ViewModelType
    var observer:((ViewModelType) -> Void)?
    
    init() {
        self.viewModel = ViewModelType()
    }
}

