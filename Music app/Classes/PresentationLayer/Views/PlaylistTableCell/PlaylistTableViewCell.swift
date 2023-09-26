//
//  AlbumTableViewCell.swift
//  Music app
//
//  Created by Tsaruk Nick on 12.09.23.
//

import UIKit



class PlaylistTableViewCell: UITableViewCell {


    @IBOutlet private weak var playlistName: UILabel!
    @IBOutlet private weak var playlistImage: UIImageView!
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

        // Configure the view for the selected state
    }
    
}
