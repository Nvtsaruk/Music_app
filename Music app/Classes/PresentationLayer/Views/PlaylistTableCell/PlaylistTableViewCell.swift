import UIKit

final class PlaylistTableViewCell: UITableViewCell {
    //MARK: - IBOutlet
    @IBOutlet private weak var playlistName: UILabel!
    @IBOutlet private weak var playlistImage: UIImageView!
    
    //MARK: - Variables
    var itemType: String = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(playlist: String, imageUrl: String) {
        playlistImage.webImage(url: imageUrl)
        playlistName.text = playlist
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
