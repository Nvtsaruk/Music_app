import UIKit

protocol TrackItemDetailTableViewCellDelegate: AnyObject {
    func addToPlaylist(trackId: String)
}

final class TrackItemDetailTableViewCell: UITableViewCell {
    //MARK: -IBOutlet
    @IBOutlet private weak var albumImage: UIImageView!
    
    @IBOutlet private weak var addButtonOutlet: UIButton!
    @IBOutlet private weak var artistNameLabel: UILabel!
    @IBOutlet private weak var trackNameLabel: UILabel!
    
    //MARK: -Variables
    var delegate: TrackItemDetailTableViewCellDelegate?
    
    var trackId: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction private func addToPlaylistButtonAction(_ sender: Any) {
        delegate?.addToPlaylist(trackId: trackId)
    }
    
    func configure(track: String, artist: String, image: String, id: String, showButton: Bool) {
        switch showButton{
            case true:
                addButtonOutlet.isHidden = false
            case false:
                addButtonOutlet.isHidden = true
        }
        albumImage.webImage(url: image)
        artistNameLabel.text = artist
        trackNameLabel.text = track
        trackId = id
    }
}
