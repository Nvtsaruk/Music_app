import UIKit
final class TopPlaylistCollectionViewCell: UICollectionViewCell {
    //MARK: -IBOutlet
    
    @IBOutlet private weak var container: UIView!
    @IBOutlet private weak var playlistImage: UIImageView!
    
    @IBOutlet private weak var playlistTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        container.backgroundColor = .darkGray
        container.clipsToBounds = true
        container.layer.cornerRadius = 8
        playlistImage.layer.cornerRadius = 8
    }
    
    func configure(title: String, imageUrl: String) {
        playlistImage.webImage(url: imageUrl)
        playlistTitle.text = title
    }
}
