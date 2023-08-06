//
//  HeaderTableViewCell.swift
//  Music app
//
//  Created by Tsaruk Nick on 6.08.23.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {

    //MARK: -IBOutlet
    
    @IBOutlet weak var headerGreetingLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: -IBAction
    
    @IBAction func settingButtonAction(_ sender: Any) {
        do {
            let del = try KeychainManager.logout(for: "access_token")
            print("Data from keychain", del)
            
        } catch {
            print(error)
        }
    }
}
