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
    
    //MARK: - Variables
    
    var viewModel: MainPageViewModelProtocol?
    
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
        viewModel?.showUserProfile()
    }
    @IBAction func historyButtonAction(_ sender: Any) {
        viewModel?.getPLaylists()
    }
    @IBAction func notificationButtonAction(_ sender: Any) {
        
    }
}
