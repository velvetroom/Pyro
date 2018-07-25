import Foundation

struct RequestError:LocalizedError {
    let errorDescription:String?
    
    static let userNotValid:RequestError = RequestError(errorDescription:NSLocalizedString(
        "RequestError.userNotValid", tableName:nil, bundle:Bundle(for:Request.self), comment:String()))
    static let noResponse:RequestError = RequestError(errorDescription:NSLocalizedString(
        "RequestError.noResponse", tableName:nil, bundle:Bundle(for:Request.self), comment:String()))
    static let emptyResponse:RequestError = RequestError(errorDescription:NSLocalizedString(
        "RequestError.emptyResponse", tableName:nil, bundle:Bundle(for:Request.self), comment:String()))
    static let banned:RequestError = RequestError(errorDescription:NSLocalizedString(
        "RequestError.banned", tableName:nil, bundle:Bundle(for:Request.self), comment:String()))
    static let fourZeroFour:RequestError = RequestError(errorDescription:NSLocalizedString(
        "RequestError.fourZeroFour", tableName:nil, bundle:Bundle(for:Request.self), comment:String()))
    static let unknown:RequestError = RequestError(errorDescription:NSLocalizedString(
        "RequestError.unknown", tableName:nil, bundle:Bundle(for:Request.self), comment:String()))
}
