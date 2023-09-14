//
//  AlbumTableViewCell.swift
//  Music app
//
//  Created by Tsaruk Nick on 12.09.23.
//

import UIKit



class AlbumTableViewCell: UITableViewCell {

    @IBOutlet private weak var artistName: UILabel!
    @IBOutlet private weak var albumName: UILabel!
    @IBOutlet private weak var albumImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(artist: String, album: String, imageUrl: URL) {
        albumImage.sd_setImage(with: imageUrl)
        albumName.text = album
        artistName.text = artist
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
