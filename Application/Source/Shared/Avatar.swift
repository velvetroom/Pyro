import UIKit

class Avatar:UIImageView {
    init() {
        super.init(frame:CGRect.zero)
        self.clipsToBounds = true
        self.contentMode = UIView.ContentMode.scaleAspectFill
        self.isUserInteractionEnabled = false
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder:NSCoder) { return nil }
    
    func load(user:String) {
        self.clear()
        guard
            !user.isEmpty,
            let url:URL = URL(string:Constants.prefix + user + Constants.suffix)
        else { return }
        URLSession.shared.dataTask(with:url) { (data:Data?, respose:URLResponse?, error:Error?) in
            guard
                let data:Data = data,
                let image:UIImage = UIImage(data:data)
            else { return }
            DispatchQueue.main.async { [weak self] in self?.fadeIn(image:image) }
        }.resume()
    }
    
    private func clear() {
        self.image = nil
        self.alpha = 0
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
