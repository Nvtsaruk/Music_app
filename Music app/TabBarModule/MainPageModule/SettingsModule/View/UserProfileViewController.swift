//
//  UserProfileViewController.swift
//  Music app
//
//  Created by Tsaruk Nick on 8.08.23.
//

import UIKit

class UserProfileViewController: UIViewController {
    
    var viewModel: UserProfileViewModelProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}

extension UserProfileViewController: Storyboarded {
    static func containingStoryboard() -> Storyboard {
        .UserProfile
    }
}
