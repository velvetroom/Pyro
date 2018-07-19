import Foundation

class RequestAnalyser {
    var data:Data?
    var response:URLResponse?
    var error:Error?
    var onCompletion:((Data) -> Void)?
    var onError:((Error) -> Void)?
        
    func analyse() {
        if let error:Error = self.error {
            self.onError?(error)
        } else if let data:Data = self.data {
            self.analyse(data:data)
        } else {
            self.onError?(RequestError.noResponse)
        }
    }
    
    private func analyse(data:Data) {
        if data.isEmpty {
            self.onError?(RequestError.emptyResponse)
        } else {
            if let response:HTTPURLResponse = response as? HTTPURLResponse {
                self.analyse(data:data, statusCode:response.statusCode)
            } else {
                self.onError?(RequestError.unknown)
            }
        }
    }
    
    private func analyse(data:Data, statusCode:Int) {
        switch statusCode {
        case Constants.success: self.onCompletion?(data)
        case Constants.banned: self.onError?(RequestError.banned)
        case Constants.fourZeroFour: self.onError?(RequestError.fourZeroFour)
        default: self.onError?(RequestError.unknown)
        }
    }
}

private struct Constants {
    static let success:Int = 200
    static let fourZeroFour:Int = 404
    static let banned:Int = 429
}
