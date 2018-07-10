import Foundation

class Request {
    private let session:URLSession
    
    init() {
        let configuration:URLSessionConfiguration = URLSessionConfiguration.background(
            withIdentifier:RequestConstants.identifier)
        configuration.allowsCellularAccess = true
        configuration.isDiscretionary = true
        configuration.networkServiceType = URLRequest.NetworkServiceType.default
        configuration.requestCachePolicy = URLRequest.CachePolicy.returnCacheDataElseLoad
        self.session = URLSession(configuration:configuration, delegate:nil, delegateQueue:OperationQueue())
    }
    
    func make(user:User, year:Int, onCompletion:@escaping((Data) -> Void), onError:@escaping((Error) -> Void)) {
        let request:URLRequest = self.makeRequest(user:user, year:year)
        session.dataTask(with:request) { (data:Data?, response:URLResponse?, error:Error?) in
            if let error:Error = error {
                onError(error)
            }
            else if let data:Data = data {
                if data.isEmpty {
                    onError(RequestError.emptyResponse)
                } else {
                    onCompletion(data)
                }
            }
            else {
                onError(RequestError.noResponse)
            }
        }
    }
    
    private func makeRequest(user:User, year:Int) -> URLRequest {
        let url:URL = URL(string:RequestConstants.urlPrefix + user.url + RequestConstants.urlMiddle +
            String(year) + RequestConstants.urlSuffix)!
        var request:URLRequest = URLRequest(url:url, cachePolicy:URLRequest.CachePolicy.returnCacheDataElseLoad,
                                            timeoutInterval:RequestConstants.timeout)
        request.httpMethod = RequestConstants.method
        request.allowsCellularAccess = true
        return request
    }
}
