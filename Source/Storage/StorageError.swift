import Foundation

struct StorageError:LocalizedError {
    let errorDescription:String?
    
    static let firstTime:StorageError = StorageError(errorDescription:
        NSLocalizedString("StorageError_FirstTime", comment:String()))
}
