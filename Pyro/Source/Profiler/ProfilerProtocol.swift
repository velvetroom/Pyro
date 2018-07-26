import Foundation

protocol ProfilerProtocol {
    var delegate:ProfilerDelegate? { get set }
    
    func load(url:String)
}
