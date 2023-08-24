//
//  ItemDetailTableViewCell.swift
//  Music app
//
//  Created by Tsaruk Nick on 18.08.23.
//

import UIKit

class ItemDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var albumImage: UIImageView!
    
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var trackNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
