import Foundation

class Profiler:ProfilerProtocol {
    weak var delegate:ProfilerDelegate?
    private var profile:Profile
    private var string:String
    private let dispatch:DispatchQueue
    
    required init() {
        self.profile = Profile()
        self.string = String()
        self.dispatch = DispatchQueue(label:Constants.identifier, qos:DispatchQoS.background,
                                      attributes:DispatchQueue.Attributes.concurrent,
                                      autoreleaseFrequency:DispatchQueue.AutoreleaseFrequency.inherit,
                                      target:DispatchQueue.global(qos:DispatchQoS.QoSClass.background))
    }
    
    func load(url:String) {
        self.profile.url = url
        self.dispatch.async {
            Configuration.requestType.profile(url:url, onCompletion: { [weak self] (data:Data) in
                self?.loaded(data:data)
                }, onError: { (error:Error) in
                    DispatchQueue.main.async { [weak self] in self?.delegate?.profileFailed(error:error) }
            })
        }
    }
    
    private func loaded(data:Data) {
        do {
            try self.parse(data:data)
        } catch let error {
            self.delegate?.profileFailed(error:error)
            return
        }
        let profile:Profile = self.profile
        DispatchQueue.main.async { [weak self] in self?.delegate?.profileLoaded(profile:profile) }
    }
    
    private func parse(data:Data) throws {
        try self.getString(data:data)
        try self.parseUser()
        try self.parseName()
        try self.parseBio()
    }
    
    private func getString(data:Data) throws {
        guard let string:String = String(data:data, encoding:String.Encoding.utf8) else { throw ProfileError.string }
        self.string = string
    }
    
    private func parseUser() throws {
        self.profile.user = try self.parse(
            prefix:Constants.userPrefix, limiter:Constants.userLimiter, error:ProfileError.user)
    }
    
    private func parseName() throws {
        self.profile.name = try self.parse(
            prefix:Constants.namePrefix, limiter:Constants.nameLimiter, error:ProfileError.name)
    }
    
    private func parseBio() throws {
        self.profile.bio = try self.parse(
            prefix:Constants.bioPrefix, limiter:Constants.bioLimiter, error:ProfileError.bio)
    }
    
    private func parse(prefix:String, limiter:String, error:Error) throws -> String {
        let components:[String] = self.string.components(separatedBy:prefix)
        if components.count > 1 {
            if let component:String = components[1].components(separatedBy:limiter).first {
                return self.strip(html:component)
            } else {
                throw error
            }
        }
        return String()
    }
    
    private func strip(html:String) -> String {
        return html.replacingOccurrences(of:Constants.expression, with:String(),
                                         options:String.CompareOptions.regularExpression, range:nil)
    }
}

private struct Constants {
    static let identifier:String = "pyro.profiler"
    static let userPrefix:String = "<meta name=\"octolytics-dimension-user_id\" content=\""
    static let userLimiter:String = "\""
    static let namePrefix:String = "<span class=\"p-name vcard-fullname d-block overflow-hidden\" itemprop=\"name\">"
    static let nameLimiter:String = "<"
    static let bioPrefix:String = "<div class=\"p-note user-profile-bio\"><div>"
    static let bioLimiter:String = "</div></div>"
    static let expression:String = "<[^>]*>"
}
