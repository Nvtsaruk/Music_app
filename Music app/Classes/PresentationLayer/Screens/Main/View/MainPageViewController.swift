import UIKit

protocol ViewDelegate: AnyObject {
    func showItemDetail(id: String)
    func reloadTableView()
}

extension ViewDelegate {
    func reloadTableView() {}
}

final class MainPageViewController: UIViewController {

    //MARK: - IBOutlet
    
    @IBOutlet private weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var tableView: UITableView!
    
    //MARK: - Variables
    var viewModel: MainPageViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setupUI()
        viewModel?.start()
        bindViewModel()
        
    }
    
    private func setupUI() {
        if viewModel?.isLoading == true {
            loadingIndicator.startAnimating()
            tableView.alpha = 0
        } 
        
        view.backgroundColor = .black
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = UIColor.white
        
        let headerNib = UINib(nibName: XibNames.headerTableViewCell.name, bundle: nil)
        tableView.register(headerNib, forCellReuseIdentifier: XibNames.headerTableViewCell.name)
        let topPlaylistsNib = UINib(nibName: XibNames.topPlaylistTableViewCell.name, bundle: nil)
        tableView.register(topPlaylistsNib, forCellReuseIdentifier: XibNames.topPlaylistTableViewCell.name)
        let playlistsTableViewNib = UINib(nibName: XibNames.playlists.name, bundle: nil)
        tableView.register(playlistsTableViewNib, forCellReuseIdentifier: XibNames.playlists.name)
    }
    
    private func bindViewModel() {
        viewModel?.updateClosure = { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
            UIView.animate(withDuration: 0.5, animations: {
                self.tableView.alpha = 1
                })
            self.loadingIndicator.stopAnimating()
        }
    }
}

extension MainPageViewController: ViewDelegate {
    func showItemDetail(id: String) {
        viewModel?.showItemDetail(id: id)
    }
}

extension MainPageViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return (viewModel?.mainPageData.playlists.count ?? 0) + 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let headerCell = tableView.dequeueReusableCell(withIdentifier: XibNames.headerTableViewCell.name) as? HeaderTableViewCell else { return UITableViewCell() }
        guard let delegate = viewModel as? any HeaderTableViewCellDelegate,
        let dayTime = viewModel?.getDayTime()
        else { return headerCell}
        headerCell.configure(delegate: delegate, greeting: dayTime)
        headerCell.delegate = viewModel as? any HeaderTableViewCellDelegate
        guard let topPlaylists = tableView.dequeueReusableCell(withIdentifier: XibNames.topPlaylistTableViewCell.name) as? TopPlaylistTableViewCell else { return UITableViewCell() }
        guard let playlistNames = self.viewModel?.mainPageData.playlistNames else { return UITableViewCell() }
        for (i, v) in playlistNames.enumerated() {
            if v == MainScreenLocalization.topList.string {
                topPlaylists.numRows = self.viewModel?.mainPageData.numRows[i] ?? 0
                topPlaylists.collectionData = self.viewModel?.mainPageData.playlists[i]
            }
        }

        topPlaylists.delegate = self
        guard let playlists = tableView.dequeueReusableCell(withIdentifier: XibNames.playlists.name) as? PlaylistsTableViewCell else { return UITableViewCell() }
        if indexPath.section >= 2 {
            playlists.numRows = self.viewModel?.mainPageData.numRows[indexPath.section - 1] ?? 0
            playlists.collectionData = self.viewModel?.mainPageData.playlists[indexPath.section - 1]
            playlists.delegate = self
        }

        switch indexPath.section {
            case 0:
                return headerCell
            case 1:
                return topPlaylists
            default:
                return playlists
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section > 0 {
            return viewModel?.mainPageData.playlistNames[section - 1]
        } else {
            return ""
        }
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
        header.textLabel?.text = header.textLabel!.text!.capitalized
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
