//
//  ArtistTableViewCell.swift
//  Music app
//
//  Created by Tsaruk Nick on 12.09.23.
//

import UIKit

class ArtistTableViewCell: UITableViewCell {

    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var artistImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    private func setupUI() {
        artistImage.layer.cornerRadius = artistImage.frame.height / 2
    }

    func configure(name: String, image: URL) {
        artistName.text = name
        artistImage.sd_setImage(with: image)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
