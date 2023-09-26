//
//  ItemDetailTableViewCell.swift
//  Music app
//
//  Created by Tsaruk Nick on 18.08.23.
//

import UIKit

protocol TrackItemDetailTableViewCellDelegate: AnyObject {
    func addToPlaylist(trackId: String)
}

class TrackItemDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var albumImage: UIImageView!
    

    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var trackNameLabel: UILabel!
    
    var delegate: TrackItemDetailTableViewCellDelegate?
    
    var trackId: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func addToPlaylistButtonAction(_ sender: Any) {
        delegate?.addToPlaylist(trackId: trackId)
    }
    func configure(track: String, artist: String, image: String, id: String) {
        albumImage.webImage(url: image)
        artistNameLabel.text = artist
        trackNameLabel.text = track
        trackId = id
    }
    
}
