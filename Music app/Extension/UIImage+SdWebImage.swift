import SDWebImage
extension UIImageView {
    func webImage(url:String?) {
        if let url = URL(string: url ?? "") {
            self.sd_setImage(with: url)
        } else {
            self.image = UIImage(systemName: "person.circle")
            self.tintColor = .white
        }
    }
}
