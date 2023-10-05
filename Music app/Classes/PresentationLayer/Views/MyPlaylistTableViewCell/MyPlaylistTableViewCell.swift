import UIKit

final class MyPlaylistTableViewCell: UITableViewCell {

    @IBOutlet private weak var numberOfTracksLabel: UILabel!
    @IBOutlet private weak var playlistNameLabel: UILabel!
    @IBOutlet private weak var playlistImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(numTracks: String, name: String, image: String) {
        numberOfTracksLabel.text = numTracks
        playlistNameLabel.text = name
        playlistImage.webImage(url: image)
    }
    
}
