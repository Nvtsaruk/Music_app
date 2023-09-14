//
//  SuggestePlaylistCollectionViewCell.swift
//  Music app
//
//  Created by Tsaruk Nick on 6.08.23.
//

import UIKit

final class TopPlaylistCollectionViewCell: UICollectionViewCell {
    
    //MARK: -IBOutlet
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var playlistImage: UIImageView!
    
    @IBOutlet weak var playlistTitle: UILabel!
    
//    @IBOutlet weak var totalTracksLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
