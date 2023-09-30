import UIKit

final class UserProfileViewController: UIViewController {
    
    //MARK: - IBOutlet
    
    @IBOutlet private weak var logoutButtonOutlet: UIButton!
    
    @IBOutlet private weak var profileImage: UIImageView!
    @IBOutlet private weak var profileDisplayName: UILabel!
    @IBOutlet private weak var myProfileLabel: UILabel!
    
    @IBOutlet private weak var userProfile: UIView!
    
    //MARK: - Variables
    private var isLoading: Bool = false
    var viewModel: UserProfileViewModelProtocol?
    
    private let symbolConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .medium, scale: .medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel?.getUserInfo()
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel?.updateClosure = { [weak self] in
            guard let self = self else { return }
            self.isLoading = ((viewModel?.isLoading) != nil)
            self.profileDisplayName.text = self.viewModel?.currentUser?.display_name
            if let url = viewModel?.currentUser?.images.first?.url {
                self.profileImage.webImage(url: url)
            } else {
                self.profileImage.image = UIImage(systemName: "person", withConfiguration: symbolConfig)
            }
        }
    }
    private func setupUI() {
        myProfileLabel.text = ProfileLocalization.myProfile.string
        
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        
        let userProfileDidTap = UITapGestureRecognizer(target: self, action: #selector(didTap(_ :)))
        userProfile.addGestureRecognizer(userProfileDidTap)

        view.backgroundColor = ColorConstants.backgroundColor
        
        logoutButtonOutlet.setTitle(ProfileLocalization.logout.string, for: .normal)
        logoutButtonOutlet.layer.cornerRadius = 19
        logoutButtonOutlet.layer.borderColor = UIColor.white.cgColor
        logoutButtonOutlet.layer.borderWidth = 1
    }
    
    @objc private func didTap(_ sender: UIGestureRecognizer) {
        viewModel?.showDetails()
    }
    
    //MARK: - IBAction
    
    @IBAction func logoutButtonAction(_ sender: Any) {
        viewModel?.logout()
    }
    
}

extension UserProfileViewController: Storyboarded {
    static func containingStoryboard() -> Storyboard {
        .UserProfile
    }
}
