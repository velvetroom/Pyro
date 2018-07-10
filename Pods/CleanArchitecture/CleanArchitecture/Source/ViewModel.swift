import Foundation

public class ViewModel {
    var items:[ObjectIdentifier:Any]
    
    init() {
        self.items = [:]
    }
    
    public func update<Property:ViewModelProtocol>(property:Property) {
        var item:ViewModelItem<Property> = ViewModelItem<Property>()
        item.property = property
        item.observer = self.item().observer
        self.items[ObjectIdentifier(Property.self)] = item
        item.observer?(property)
    }
    
    public func observe<Property:ViewModelProtocol>(observer:@escaping((Property) -> Void)) {
        var item:ViewModelItem<Property> = self.item()
        item.observer = observer
        self.items[ObjectIdentifier(Property.self)] = item
    }
    
    private func item<Property:ViewModelProtocol>() -> ViewModelItem<Property> {
        guard
            let item:ViewModelItem<Property> = self.items[ObjectIdentifier(Property.self)] as? ViewModelItem<Property>
        else { return ViewModelItem<Property>() }
        return item
    }
}

public protocol ViewModelProtocol {
    init()
}

private struct ViewModelItem<Property:ViewModelProtocol> {
    var property:Property
    var observer:((Property) -> Void)?
    
    init() {
        self.property = Property()
    }
}

