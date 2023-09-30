import UIKit

final class AddToPlaylistViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var readyButtonOutlet: UIButton!
    @IBOutlet private weak var createPlaylistButtonOutlet: UIButton!
    
    var viewModel: AddToPlaylistViewModelProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.start()
        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        readyButtonOutlet.setTitle(NSLocalizedString("ready", comment: ""), for: .normal)
        
        tableView.delegate = self
        tableView.dataSource = self
        let tablePlaylistNib = UINib(nibName: XibNames.myPlaylist.name, bundle: nil)
        tableView.register(tablePlaylistNib, forCellReuseIdentifier: XibNames.myPlaylist.name)
        readyButtonOutlet.layer.cornerRadius = readyButtonOutlet.frame.height / 2
        createPlaylistButtonOutlet.layer.cornerRadius = createPlaylistButtonOutlet.frame.height / 2
    }
    
    private func bindViewModel() {
        viewModel?.updateClosure = { [weak self] in
            guard let self = self else { return }
            
            tableView.reloadData()
            
        }
    }
    
    
    @IBAction private func cancelButtonAction(_ sender: Any) {
        viewModel?.cancel()
    }
    @IBAction func createPlaylistButtonAction(_ sender: Any) {
        var playlistName = ""
        let alert = UIAlertController(title: "Playlist name", message: "Enter name of playlist", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
         
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Enter playlist name"
        })
         
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
         
            if let name = alert.textFields?.first?.text {
                playlistName = name
                self.viewModel?.createPlaylist(playlistName: playlistName)
            }
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    @IBAction private func readyButtonAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
}

extension AddToPlaylistViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.playlist.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tablePlaylistCell = tableView.dequeueReusableCell(withIdentifier: XibNames.myPlaylist.name) as? MyPlaylistTableViewCell else { return UITableViewCell()}
        guard let numTracks = viewModel?.playlist[indexPath.row].tracks.count,
              let name = viewModel?.playlist[indexPath.row].playlistName,
              let image = viewModel?.playlist[indexPath.row].tracks.first?.image
        else { return tablePlaylistCell}
        tablePlaylistCell.configure(numTracks: String(numTracks), name: name, image: image)
        return tablePlaylistCell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel?.deletePlaylist(playlistIndex: indexPath.row)
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.selectedPlaylist(id: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: false)
    }

    
    
}

extension AddToPlaylistViewController: Storyboarded {
    static func containingStoryboard() -> Storyboard {
        .AddToPlaylist
    }
}

