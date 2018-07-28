import Foundation

protocol ProfilerDelegate:AnyObject {
    func profileLoaded(profile:Profile)
    func profileFailed(error:Error)
}
