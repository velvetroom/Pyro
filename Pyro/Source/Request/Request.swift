import Foundation

class Request:RequestProtocol {
    private static let monostate:Request = Request()
    private let session:URLSession
    private weak var task:URLSessionDataTask?
    
    class func contributions(user:UserProtocol, year:Int,
                             onCompletion:@escaping((Data) -> Void), onError:@escaping((Error) -> Void)) {
        guard
            let url:URL = URL(string:Constants.domain + Constants.users + user.url + Constants.contributions +
                String(year) + Constants.date)
        else { return onError(RequestError.userNotValid) }
        Request.monostate.make(request:request(url:url), onCompletion:onCompletion, onError:onError)
    }
    
    class func validate(url:String, onCompletion:@escaping((Data) -> Void), onError:@escaping((Error) -> Void)) {
        guard
            let url:URL = URL(string:Constants.domain + Constants.users + url + Constants.contributions)
        else { return onError(RequestError.userNotValid) }
        Request.monostate.make(request:request(url:url), onCompletion:onCompletion, onError:onError)
    }
    
    private init() {
        let configuration:URLSessionConfiguration = URLSessionConfiguration.ephemeral
        configuration.allowsCellularAccess = true
        configuration.isDiscretionary = true
        configuration.networkServiceType = URLRequest.NetworkServiceType.default
        configuration.requestCachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData
        self.session = URLSession(configuration:configuration, delegate:nil, delegateQueue:OperationQueue())
    }
    
    private class func request(url:URL) -> URLRequest {
        var request:URLRequest = URLRequest(url:url, cachePolicy:
            URLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData, timeoutInterval:Constants.timeout)
        request.httpMethod = Constants.method
        request.allowsCellularAccess = true
        return request
    }
    
    private func make(request:URLRequest, onCompletion:@escaping((Data) -> Void), onError:@escaping((Error) -> Void)) {
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
}

private struct Constants {
    static let method:String = "GET"
    static let domain:String = "https://github.com/"
    static let users:String = "users/"
    static let contributions:String = "/contributions?from="
    static let date:String = "-01-01"
    static let timeout:TimeInterval = 15
}
