import Foundation

public class Factory {
    public class func makeReport() -> ReportProtocol { return Report() }
    public class func makeStorage() -> StorageProtocol { return Storage() }
    
    private init() { }
}
