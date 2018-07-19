import Foundation

class Request:RequestProtocol {
    private let session:URLSession
    private weak var task:URLSessionDataTask?
    
    init() {
        let configuration:URLSessionConfiguration = URLSessionConfiguration.ephemeral
        configuration.allowsCellularAccess = true
        configuration.isDiscretionary = true
        configuration.networkServiceType = URLRequest.NetworkServiceType.default
        configuration.requestCachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData
        self.session = URLSession(configuration:configuration, delegate:nil, delegateQueue:OperationQueue())
    }
    
    func make(user:User, year:Int, onCompletion:@escaping((Data) -> Void), onError:@escaping((Error) -> Void)) {
        guard
            let request:URLRequest = self.request(user:user, year:year)
        else {
            onError(RequestError.userNotValid)
            return
        }
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
    
    private func request(user:User, year:Int) -> URLRequest? {
        guard
            let userPath:String = user.url.addingPercentEncoding(withAllowedCharacters:CharacterSet.urlPathAllowed),
            let url:URL = URL(string:Constants.urlPrefix + userPath + Constants.urlMiddle + String(year) +
                Constants.urlSuffix)
        else { return nil }
        var request:URLRequest = URLRequest(url:url, cachePolicy:
            URLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData, timeoutInterval:Constants.timeout)
        request.httpMethod = Constants.method
        request.allowsCellularAccess = true
        return request
    }
}

private struct Constants {
    static let method:String = "GET"
    static let urlPrefix:String = "https://github.com/users/"
    static let urlMiddle:String = "/contributions?from="
    static let urlSuffix:String = "-01-01"
    static let timeout:TimeInterval = 15
}
