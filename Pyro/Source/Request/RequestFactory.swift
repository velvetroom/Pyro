import Foundation

class RequestFactory {
    class func makeSession() -> URLSession {
        return URLSession(configuration:makeConfiguration(), delegate:nil, delegateQueue:OperationQueue())
    }
    
    class func makeRequest(user:User, year:Int) -> URLRequest {
        var request:URLRequest = URLRequest(url:makeUrl(user:user, year:year),
                                            cachePolicy:URLRequest.CachePolicy.returnCacheDataElseLoad,
                                            timeoutInterval:RequestConstants.timeout)
        request.httpMethod = RequestConstants.method
        request.allowsCellularAccess = true
        return request
    }
    
    private class func makeConfiguration() -> URLSessionConfiguration {
        let configuration:URLSessionConfiguration = URLSessionConfiguration.background(
            withIdentifier:RequestConstants.identifier)
        configuration.allowsCellularAccess = true
        configuration.isDiscretionary = true
        configuration.networkServiceType = URLRequest.NetworkServiceType.default
        configuration.requestCachePolicy = URLRequest.CachePolicy.returnCacheDataElseLoad
        return configuration
    }
    
    private class func makeUrl(user:User, year:Int) -> URL {
        return URL(string:RequestConstants.urlPrefix + user.url + RequestConstants.urlMiddle +
            String(year) + RequestConstants.urlSuffix)!
    }
    
    private init() { }
}
