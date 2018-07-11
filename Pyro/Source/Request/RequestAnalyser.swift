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
        case RequestConstants.codeSuccess:
            self.onCompletion?(data)
        case RequestConstants.codeBanned:
            self.onError?(RequestError.banned)
        case RequestConstants.codeFourZeroFour:
            self.onError?(RequestError.fourZeroFour)
        default:
            self.onError?(RequestError.unknown)
        }
    }
}
