import Foundation

struct StorageError:LocalizedError {
    let errorDescription:String?
    
    static let firstTime:StorageError = StorageError(errorDescription:NSLocalizedString(
        "StorageError_FirstTime", tableName:nil, bundle:Bundle(for:Request.self), comment:String()))
}
