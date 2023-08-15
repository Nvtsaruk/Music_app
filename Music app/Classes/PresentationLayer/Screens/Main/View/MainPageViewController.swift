import UIKit

class MainPageViewController: UIViewController {

    //MARK: - IBOutlet
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Variables
    var viewModel: MainPageViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        setupUI()
        viewModel?.start()
        viewModel?.getNewRelises()
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        let headerNib = UINib(nibName: "HeaderTableViewCell", bundle: nil)
        tableView.register(headerNib, forCellReuseIdentifier: "HeaderTableViewCell")
        let suggestedNib = UINib(nibName: "SuggestedPlaylistTableViewCell", bundle: nil)
        tableView.register(suggestedNib, forCellReuseIdentifier: "SuggestedPlaylistTableViewCell")
    }
    


}

extension MainPageViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell") as? HeaderTableViewCell else { return UITableViewCell() }
        headerCell.delegate = viewModel as? any HeaderTableViewCellDelegate
        guard let suggestedCell = tableView.dequeueReusableCell(withIdentifier: "SuggestedPlaylistTableViewCell") as? SuggestedPlaylistTableViewCell else { return UITableViewCell() }
        DispatchQueue.main.async {
            suggestedCell.numRows = self.viewModel?.mainPageData.numRows ?? 0
            suggestedCell.collectionData = self.viewModel?.mainPageData.newReleases
        }
        
            
       
        
        switch indexPath.section {
            case 0:
                return headerCell
            case 1:
                return suggestedCell
            default:
                return headerCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
    }
}
extension MainPageViewController: Storyboarded {
    static func containingStoryboard() -> Storyboard {
        .MainPage
    }
}
