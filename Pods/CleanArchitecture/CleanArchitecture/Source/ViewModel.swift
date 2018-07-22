import Foundation

public class ViewModel {
    var items:[ObjectIdentifier:Any]
    
    init() {
        self.items = [:]
    }
    
    public func update<Property:ViewModelProtocol>(property:Property) {
        var item:Item<Property> = Item<Property>()
        item.property = property
        item.observer = self.item().observer
        self.items[ObjectIdentifier(Property.self)] = item
        DispatchQueue.main.async { item.observer?(property) }
    }
    
    public func observe<Property:ViewModelProtocol>(observer:@escaping((Property) -> Void)) {
        var item:Item<Property> = self.item()
        item.observer = observer
        self.items[ObjectIdentifier(Property.self)] = item
    }
    
    private func item<Property:ViewModelProtocol>() -> Item<Property> {
        guard
            let item:Item<Property> = self.items[ObjectIdentifier(Property.self)] as? Item<Property>
        else { return Item<Property>() }
        return item
    }
}

public protocol ViewModelProtocol {
    init()
}

private struct Item<Property:ViewModelProtocol> {
    var property:Property
    var observer:((Property) -> Void)?
    
    init() {
        self.property = Property()
    }
}

