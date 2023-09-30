import UIKit

final class MyMediaPageViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet private weak var emptyLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    
    @IBOutlet private weak var tableView: UITableView!
    
    //MARK: - Variables
    var viewModel: MyMediaPageViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.start()
        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        setEmptyLabel()
        titleLabel.text = NSLocalizedString("myPlaylists", comment: "")
        tableView.delegate = self
        tableView.dataSource = self
        let tablePlaylistNib = UINib(nibName: XibNames.playlist.name, bundle: nil)
        tableView.register(tablePlaylistNib, forCellReuseIdentifier: XibNames.playlist.name)
    }
    
    private func bindViewModel() {
        viewModel?.updateClosure = { [weak self] in
            guard let self = self else { return }
            setEmptyLabel()
            tableView.reloadData()
        }
    }
    
    private func setEmptyLabel() {
        guard let empty = viewModel?.databasePlaylist.isEmpty else { return }
        if empty {
            emptyLabel.text = NSLocalizedString("emptyPlaylists", comment: "")
            emptyLabel.isHidden = false
        } else {
            emptyLabel.isHidden = true
        }
    }
}

extension MyMediaPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.databasePlaylist.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tablePlaylistCell = tableView.dequeueReusableCell(withIdentifier: XibNames.playlist.name) as? PlaylistTableViewCell else { return UITableViewCell()}
        guard let name = viewModel?.databasePlaylist[indexPath.row].playlistName,
              let image = viewModel?.databasePlaylist[indexPath.row].tracks.first?.image
        else { return tablePlaylistCell}
        tablePlaylistCell.configure(playlist: name, imageUrl: image)
        return tablePlaylistCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.showPlaylist(id: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: false)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel?.deletePlaylist(playlistIndex: indexPath.row)
        }
    }
    
    
}

extension MyMediaPageViewController: Storyboarded {
    static func containingStoryboard() -> Storyboard {
        return .MyMediaPage
    }
    
    
}
