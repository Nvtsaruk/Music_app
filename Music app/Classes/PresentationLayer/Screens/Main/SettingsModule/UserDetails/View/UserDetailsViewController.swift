//
//  UserDetailsViewController.swift
//  Music app
//
//  Created by Tsaruk Nick on 15.08.23.
//

import UIKit

class UserDetailsViewController: UIViewController {

    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subscribersLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!

    var viewModel: UserDetailsViewModelProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

}

extension UserDetailsViewController: Storyboarded {
    static func containingStoryboard() -> Storyboard {
        .UserDetails
    }
}
