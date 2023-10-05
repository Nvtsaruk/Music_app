import UIKit
protocol HeaderTableViewCellDelegate: AnyObject {
    func goToUserProfile()
}
final class HeaderTableViewCell: UITableViewCell {
    //MARK: -IBOutlet
    @IBOutlet private weak var headerGreetingLabel: UILabel!
    
    //MARK: - Variables
    weak var delegate: HeaderTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(delegate: HeaderTableViewCellDelegate, greeting: String) {
        headerGreetingLabel.text = greeting
        self.delegate = delegate
    }
    
    //MARK: -IBAction
    @IBAction private func settingButtonAction(_ sender: Any) {
        delegate?.goToUserProfile()
    }
}
