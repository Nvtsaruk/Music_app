import UIKit

final class ArtistItemDetailViewController: UIViewController {
    
    @IBOutlet private weak var artistImage: UIImageView!
    
    @IBOutlet private weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var playPauseButtonOutlet: UIButton!
    @IBOutlet private weak var artistNameLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    var viewModel: ArtistItemDetailViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.getArtistInfo()
        viewModel?.start()
        bindViewModel()
        setupUI()
    }
    
    private func setupUI() {
        if viewModel?.isLoading == true {
            loadingIndicator.startAnimating()
        }

        tableView.dataSource = self
        tableView.delegate = self
        let itemDetailNib = UINib(nibName: XibNames.trackItemDetailTableViewCell.name, bundle: nil)
        tableView.register(itemDetailNib, forCellReuseIdentifier: XibNames.trackItemDetailTableViewCell.name)
    }
    
    private func bindViewModel() {
        viewModel?.updateClosure = { [weak self] in
            guard let self = self else { return }
            if viewModel?.isLoading == true {
                loadingIndicator.startAnimating()
            }

            guard let imageURL = viewModel?.artist?.images.first?.url,
                  let artistName = viewModel?.artist?.name
            else { return }
            artistNameLabel.text = artistName
            artistImage.webImage(url: imageURL)
            loadingIndicator.stopAnimating()
            tableView.reloadData()
            if self.viewModel?.isPlaying == true {
                self.playPauseButtonOutlet.setImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
            } else {
                self.playPauseButtonOutlet.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
            }
        }
    }
    
    @IBAction func playPauseButtonAction(_ sender: Any) {
        viewModel?.playButtonAction()
    }
}

extension ArtistItemDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.topTracks.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let trackCell = tableView.dequeueReusableCell(withIdentifier: XibNames.trackItemDetailTableViewCell.name) as? TrackItemDetailTableViewCell else { return UITableViewCell() }
        trackCell.delegate = viewModel as? any TrackItemDetailTableViewCellDelegate
        guard let artist = viewModel?.topTracks[indexPath.row].artists.first?.name,
              let track = viewModel?.topTracks[indexPath.row].name,
              let url = viewModel?.topTracks[indexPath.row].album.images.first?.url,
              let id = viewModel?.topTracks[indexPath.row].id
        else { return trackCell }
        trackCell.configure(track: track, artist: artist, image: url, id: id, showButton: true)
        return trackCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.addPlayItems(itemIndex: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension ArtistItemDetailViewController: Storyboarded {
    static func containingStoryboard() -> Storyboard {
        .ArtistItemDetail
    }
}

