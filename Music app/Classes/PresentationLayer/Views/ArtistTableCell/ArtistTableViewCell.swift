import UIKit
final class ArtistTableViewCell: UITableViewCell {
    //MARK: - IBOutlet
    @IBOutlet private weak var artistName: UILabel!
    @IBOutlet private weak var artistImage: UIImageView!
    
    //MARK: - Variables
    var itemType: String = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    private func setupUI() {
        artistImage.layer.cornerRadius = artistImage.frame.height / 2
    }

    func configure(name: String, image: String?) {
        artistName.text = name
        artistImage.webImage(url: image)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
