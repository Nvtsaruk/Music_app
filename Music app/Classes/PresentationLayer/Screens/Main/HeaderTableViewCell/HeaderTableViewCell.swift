import UIKit

protocol HeaderTableViewCellDelegate: AnyObject {
    func goToUserProfile()
}
final class HeaderTableViewCell: UITableViewCell {
    
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
}
