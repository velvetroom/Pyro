import Foundation

class Storage:StorageProtocol {
    var store:Store
    var file:StorageFileProtocol
    private let dispatch:DispatchQueue
    
    init() {
        self.store = Store()
        self.file = StorageFile()
        self.dispatch = DispatchQueue(label:StorageConstants.identifier, qos:DispatchQoS.background,
                                      attributes:DispatchQueue.Attributes.concurrent,
                                      autoreleaseFrequency:DispatchQueue.AutoreleaseFrequency.inherit,
                                      target:DispatchQueue.global(qos:DispatchQoS.QoSClass.background))
    }
    
    func load(onCompletion:@escaping(([User]) -> Void)) {
        self.dispatch.async { [weak self] in
            do { try self?.loadFromFile() } catch { self?.loadFromDefault() }
            DispatchQueue.main.async { [weak self] in
                guard let store:Store = self?.store else { return }
                onCompletion(store.users)
            }
        }
    }
    
    func save(users:[User]) {
        self.dispatch.async { [weak self] in
            self?.store.users = users
            self?.save()
        }
    }
    
    private func loadFromFile() throws {
        let data:Data = try self.file.load()
        self.loaded(data:data)
    }
    
    private func loadFromDefault() {
        let url:URL = Bundle(for:type(of:self)).url(forResource:StorageConstants.file, withExtension:nil)!
        let data:Data
        do { try data = Data(contentsOf:url, options:Data.ReadingOptions.uncached) } catch { return }
        self.loaded(data:data)
        self.save()
    }
    
    private func loaded(data:Data) {
        do { try self.store = JSONDecoder().decode(Store.self, from:data) } catch { }
    }
    
    private func save() {
        let data:Data
        do { try data = JSONEncoder().encode(self.store) } catch { return }
        self.save(data:data)
    }
    
    private func save(data:Data) {
        do { try self.file.save(data:data) } catch { }
    }
}
