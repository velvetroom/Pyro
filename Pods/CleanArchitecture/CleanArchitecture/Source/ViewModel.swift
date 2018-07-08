import Foundation

open class ViewModel {
    var properties:[ObjectIdentifier:Any]
    
    public init() {
        self.properties = [:]
    }
    
    open func update<ViewModelProperty:ViewModelPropertyProtocol>(property:ViewModelProperty) {
        let property:ViewModelProperty = self.observedProperty(property:property)
        let identifier:ObjectIdentifier = ObjectIdentifier(type(of:property))
        self.properties[identifier] = property
        property.notifyObserver()
    }
    
    open func property<ViewModelProperty:ViewModelPropertyProtocol>() -> ViewModelProperty {
        let identifier:ObjectIdentifier = ObjectIdentifier(ViewModelProperty.self)
        guard
            let viewModel:ViewModelProperty = self.properties[identifier] as? ViewModelProperty
        else { return ViewModelProperty() }
        return viewModel
    }
    
    private func observedProperty<ViewModelProperty:ViewModelPropertyProtocol>(
        property:ViewModelProperty) -> ViewModelProperty {
        var property:ViewModelProperty = property
        if property.observing == nil {
            let previousProperty:ViewModelProperty = self.property()
            if previousProperty.observing != nil {
                property.observing = previousProperty.observing
            }
        }
        return property
    }
}
