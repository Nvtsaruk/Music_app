import UIKit

final class MyPlaylistTableViewCell: UITableViewCell {

    @IBOutlet weak var numberOfTracksLabel: UILabel!
    @IBOutlet weak var playlistNameLabel: UILabel!
    @IBOutlet weak var playlistImage: UIImageView!

    @IBOutlet weak var checkBoxImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(numTracks: String, name: String, image: String) {
        numberOfTracksLabel.text = numTracks
        playlistNameLabel.text = name
        playlistImage.webImage(url: image)
    }
    
}
