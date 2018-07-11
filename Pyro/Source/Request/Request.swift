import Foundation

class Request:RequestProtocol {
    private let session:URLSession
    private weak var task:URLSessionDataTask?
    
    init() {
        let configuration:URLSessionConfiguration = URLSessionConfiguration.ephemeral
        configuration.allowsCellularAccess = true
        configuration.isDiscretionary = true
        configuration.networkServiceType = URLRequest.NetworkServiceType.default
        configuration.requestCachePolicy = URLRequest.CachePolicy.reloadIgnoringCacheData
        self.session = URLSession(configuration:configuration, delegate:nil, delegateQueue:OperationQueue())
    }
    
    func make(user:User, year:Int, onCompletion:@escaping((Data) -> Void), onError:@escaping((Error) -> Void)) {
        let request:URLRequest = self.request(user:user, year:year)
        self.task?.cancel()
        self.task = self.session.dataTask(with:request) { (data:Data?, response:URLResponse?, error:Error?) in
            let analyser:RequestAnalyser = RequestAnalyser()
            analyser.data = data
            analyser.response = response
            analyser.error = error
            analyser.onCompletion = onCompletion
            analyser.onError = onError
            analyser.analyse()
        }
        self.task?.resume()
    }
    
    private func request(user:User, year:Int) -> URLRequest {
        let url:URL = URL(string:RequestConstants.urlPrefix + user.url + RequestConstants.urlMiddle +
            String(year) + RequestConstants.urlSuffix)!
        var request:URLRequest = URLRequest(url:url, cachePolicy:URLRequest.CachePolicy.reloadIgnoringCacheData,
                                            timeoutInterval:RequestConstants.timeout)
        request.httpMethod = RequestConstants.method
        request.allowsCellularAccess = true
        return request
    }
}
