//
//  MyPlaylistTableViewCell.swift
//  Music app
//
//  Created by Tsaruk Nick on 21.09.23.
//

import UIKit

class MyPlaylistTableViewCell: UITableViewCell {

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
    
}
