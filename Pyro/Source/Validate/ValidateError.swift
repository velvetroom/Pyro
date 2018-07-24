import Foundation

struct ValidateError:LocalizedError {
    let errorDescription:String?
    
    static let empty:ValidateError = ValidateError(errorDescription:NSLocalizedString(
        "ValidateError_empty", tableName:nil, bundle:Bundle(for:Pyro.self), comment:String()))
    static let first:ValidateError = ValidateError(errorDescription:NSLocalizedString(
        "ValidateError_first", tableName:nil, bundle:Bundle(for:Pyro.self), comment:String()))
    static let character:ValidateError = ValidateError(errorDescription:NSLocalizedString(
        "ValidateError_character", tableName:nil, bundle:Bundle(for:Pyro.self), comment:String()))
    static let unique:ValidateError = ValidateError(errorDescription:NSLocalizedString(
        "ValidateError_unique", tableName:nil, bundle:Bundle(for:Pyro.self), comment:String()))
}
