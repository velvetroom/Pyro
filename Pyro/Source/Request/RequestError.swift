import Foundation

struct RequestError:LocalizedError {
    let errorDescription:String?
    
    static let noResponse:RequestError = RequestError(errorDescription:NSLocalizedString(
        "RequestError_noResponse", tableName:nil, bundle:Bundle(for:Request.self), comment:String()))
    static let emptyResponse:RequestError = RequestError(errorDescription:NSLocalizedString(
        "RequestError_emptyResponse", tableName:nil, bundle:Bundle(for:Request.self), comment:String()))
}
