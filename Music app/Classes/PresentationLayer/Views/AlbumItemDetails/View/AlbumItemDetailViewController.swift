import UIKit

final class AlbumItemDetailViewController: UIViewController {
    //MARK: -IBOutlets
    
    @IBOutlet var albumImageOutlet: UIImageView!
    @IBOutlet var artistImageOutlet: UIImageView!
    
    @IBOutlet var albumTitleLabel: UILabel!
    @IBOutlet var artistNameLabel: UILabel!
    @IBOutlet var typeAndYearLabel: UILabel!
    
    @IBOutlet var playPauseButtonOutlet: UIButton!
    
    @IBOutlet var tableView: UITableView!
    //MARK: -Variables
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func playPauseButtonAction(_ sender: Any) {
        
    }
    
    
}

extension AlbumItemDetailViewController: Storyboarded {
    static func containingStoryboard() -> Storyboard {
        .PlaylistItemDetail
    }
}
