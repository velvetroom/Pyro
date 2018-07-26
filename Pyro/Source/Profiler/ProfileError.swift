import Foundation

struct ProfileError:LocalizedError {
    let errorDescription:String?
    
    static let string:ValidateError = ValidateError(errorDescription:NSLocalizedString(
        "ProfileError.string", tableName:nil, bundle:Bundle(for:Pyro.self), comment:String()))
    static let user:ValidateError = ValidateError(errorDescription:NSLocalizedString(
        "ProfileError.user", tableName:nil, bundle:Bundle(for:Pyro.self), comment:String()))
    static let name:ValidateError = ValidateError(errorDescription:NSLocalizedString(
        "ProfileError.name", tableName:nil, bundle:Bundle(for:Pyro.self), comment:String()))
    static let bio:ValidateError = ValidateError(errorDescription:NSLocalizedString(
        "ProfileError.bio", tableName:nil, bundle:Bundle(for:Pyro.self), comment:String()))
}
