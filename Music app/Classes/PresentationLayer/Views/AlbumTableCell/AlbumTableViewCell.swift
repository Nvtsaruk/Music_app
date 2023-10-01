import UIKit
final class AlbumTableViewCell: UITableViewCell {
    //MARK: - IBOutlet
    @IBOutlet private weak var artistName: UILabel!
    @IBOutlet private weak var albumName: UILabel!
    @IBOutlet private weak var albumImage: UIImageView!
    
    //MARK: - Variables
    var itemType: String = ""
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(artist: String, album: String, imageUrl: String) {
        albumImage.webImage(url: imageUrl)
        albumName.text = album
        artistName.text = artist
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
