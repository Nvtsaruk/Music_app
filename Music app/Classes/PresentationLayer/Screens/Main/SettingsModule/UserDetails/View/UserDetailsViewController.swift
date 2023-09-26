//
//  UserDetailsViewController.swift
//  Music app
//
//  Created by Tsaruk Nick on 15.08.23.
//

import UIKit

class Colors {
    var gl:CAGradientLayer!
    var colorTop: CGColor
    var colorBottom: CGColor
    
    init(colorTop: CGColor, colorBottom: CGColor) {
        self.colorTop = colorTop
        self.colorBottom = colorBottom
        self.gl = CAGradientLayer()
        self.gl.colors = [colorTop, colorBottom]
        self.gl.locations = [0.0, 0.3]
    }
}

class UserDetailsViewController: UIViewController {
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var planLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var userIDLabel: UILabel!
    
    var viewModel: UserDetailsViewModelProtocol?
    let symbolConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .medium, scale: .medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        refresh()
    }
    let colors = Colors(colorTop: UIColor.gray.cgColor, colorBottom: UIColor.black.cgColor)

      func refresh() {
          view.backgroundColor = UIColor.clear
          let backgroundLayer = colors.gl
          backgroundLayer?.frame = view.frame
          view.layer.insertSublayer(backgroundLayer ?? CAGradientLayer(), at: 0)
          }
      
    
    private func setupUI() {
        avatarImage.layer.cornerRadius = avatarImage.frame.height / 2
        nameLabel.text = viewModel?.currentUser?.display_name
        planLabel.text = "Plan: \(viewModel?.currentUser?.product ?? "")"
        countryLabel.text = "Country: \(viewModel?.currentUser?.country ?? "")"
        userIDLabel.text = "User ID: \(viewModel?.currentUser?.id ?? "")"
        emailLabel.text = "Email: \(viewModel?.currentUser?.email ?? "")"
        if let url = viewModel?.currentUser?.images.first?.url {
            self.avatarImage.webImage(url: url)
        } else {
            self.avatarImage.image = UIImage(systemName: "person", withConfiguration: symbolConfig)
        }
    }
    
    
}

extension UserDetailsViewController: Storyboarded {
    static func containingStoryboard() -> Storyboard {
        .UserDetails
    }
}
