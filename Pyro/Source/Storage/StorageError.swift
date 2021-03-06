import Foundation

struct StorageError:LocalizedError {
    let errorDescription:String?
    
    static let fileNotFound:StorageError = StorageError(errorDescription:NSLocalizedString(
        "StorageError.fileNotFound", tableName:nil, bundle:Bundle(for:Storage.self), comment:String()))
}
