import UIKit

final class UserDetailsViewController: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet private weak var avatarImage: UIImageView!
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var planLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var countryLabel: UILabel!
    @IBOutlet private weak var userIDLabel: UILabel!
    
    //MARK: - Variables
    var viewModel: UserDetailsViewModelProtocol?
    private let symbolConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .medium, scale: .medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        refresh()
    }
    
    private let colors = Colors(colorTop: UIColor.gray.cgColor, colorBottom: UIColor.black.cgColor)
    
    private func refresh() {
        view.backgroundColor = UIColor.clear
        let backgroundLayer = colors.gl
        backgroundLayer?.frame = view.frame
        view.layer.insertSublayer(backgroundLayer ?? CAGradientLayer(), at: 0)
    }
    
    private func setupUI() {
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = UIColor.white
        
        avatarImage.layer.cornerRadius = avatarImage.frame.height / 2
        nameLabel.text = viewModel?.currentUser?.display_name
        
        let planLocalizedString = ProfileLocalization.plan.string
        let countryLocalizedString = ProfileLocalization.country.string
        let userIDLocalizedString = ProfileLocalization.userID.string
        let emailLocalizedString = ProfileLocalization.email.string
        
        planLabel.text = planLocalizedString + " " + (viewModel?.currentUser?.product ?? "")
        countryLabel.text = countryLocalizedString + " " + (viewModel?.currentUser?.country ?? "")
        userIDLabel.text = userIDLocalizedString + " " + (viewModel?.currentUser?.id ?? "")
        emailLabel.text = emailLocalizedString + " " + (viewModel?.currentUser?.email ?? "")
        
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
