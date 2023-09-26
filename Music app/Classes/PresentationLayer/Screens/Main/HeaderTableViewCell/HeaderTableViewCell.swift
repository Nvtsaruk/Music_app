//
//  HeaderTableViewCell.swift
//  Music app
//
//  Created by Tsaruk Nick on 6.08.23.
//

import UIKit

protocol HeaderTableViewCellDelegate: AnyObject {
    func goToUserProfile()
    func cleanKeychain()
}




class HeaderTableViewCell: UITableViewCell {
    
    //MARK: -IBOutlet
    
    @IBOutlet weak var headerGreetingLabel: UILabel!
    
    //MARK: - Variables
    
    weak var delegate: HeaderTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    //MARK: -IBAction
    
    @IBAction func settingButtonAction(_ sender: Any) {
        delegate?.goToUserProfile()
    }
    @IBAction func historyButtonAction(_ sender: Any) {
        //        viewModel?.getPLaylists()
    }
    @IBAction func notificationButtonAction(_ sender: Any) {
        delegate?.cleanKeychain()
    }
}
