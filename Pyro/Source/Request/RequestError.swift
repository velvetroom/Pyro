import Foundation

struct RequestError:LocalizedError {
    let errorDescription:String?
    
    static let userNotValid:RequestError = RequestError(errorDescription:NSLocalizedString(
        "RequestError_userNotValid", tableName:nil, bundle:Bundle(for:Request.self), comment:String()))
    static let noResponse:RequestError = RequestError(errorDescription:NSLocalizedString(
        "RequestError_noResponse", tableName:nil, bundle:Bundle(for:Request.self), comment:String()))
    static let emptyResponse:RequestError = RequestError(errorDescription:NSLocalizedString(
        "RequestError_emptyResponse", tableName:nil, bundle:Bundle(for:Request.self), comment:String()))
    static let banned:RequestError = RequestError(errorDescription:NSLocalizedString(
        "RequestError_banned", tableName:nil, bundle:Bundle(for:Request.self), comment:String()))
    static let fourZeroFour:RequestError = RequestError(errorDescription:NSLocalizedString(
        "RequestError_fourZeroFour", tableName:nil, bundle:Bundle(for:Request.self), comment:String()))
    static let unknown:RequestError = RequestError(errorDescription:NSLocalizedString(
        "RequestError_unknown", tableName:nil, bundle:Bundle(for:Request.self), comment:String()))
}
