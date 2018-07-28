import UIKit

class Avatar:UIImageView {
    private var user:String
    
    init() {
        self.user = String()
        super.init(frame:CGRect.zero)
        self.clipsToBounds = true
        self.contentMode = UIView.ContentMode.scaleAspectFill
        self.isUserInteractionEnabled = false
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder:NSCoder) { return nil }
    
    func load(user:String) {
        if user != self.user {
            self.clear()
            guard
                !user.isEmpty,
                let url:URL = URL(string:Constants.prefix + user + Constants.suffix)
            else { return }
            self.user = user
            DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async { [weak self] in
                self?.request(url:url)
            }
        }
    }
    
    private func clear() {
        self.user = String()
        self.image = nil
        self.alpha = 0
    }
    
    private func request(url:URL) {
        URLSession.shared.dataTask(with:url) { (data:Data?, respose:URLResponse?, error:Error?) in
            guard
                let data:Data = data,
                let image:UIImage = UIImage(data:data)
            else { return }
            DispatchQueue.main.async { [weak self] in self?.fadeIn(image:image) }
        }.resume()
    }
    
    private func fadeIn(image:UIImage) {
        self.image = image
        UIView.animate(withDuration:Constants.animation) { [weak self] in self?.alpha = 1 }
    }
}

private struct Constants {
    static let animation:TimeInterval = 0.3
    static let prefix:String = "https://avatars.githubusercontent.com/u/"
    static let suffix:String = "?s=500"
}
