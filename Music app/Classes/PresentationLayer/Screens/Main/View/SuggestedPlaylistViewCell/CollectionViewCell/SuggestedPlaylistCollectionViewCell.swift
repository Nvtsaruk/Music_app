//
//  SuggestePlaylistCollectionViewCell.swift
//  Music app
//
//  Created by Tsaruk Nick on 6.08.23.
//

import UIKit

final class SuggestedPlaylistCollectionViewCell: UICollectionViewCell {
    
    //MARK: -IBOutlet
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var playlistImage: UIImageView!
    
    @IBOutlet weak var playlistTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = .clear
        container.backgroundColor = .darkGray
        container.clipsToBounds = true
        container.layer.cornerRadius = 8
        playlistImage.layer.cornerRadius = 4
    }

}
