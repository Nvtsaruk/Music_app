import UIKit

final class ArtistItemDetailViewController: UIViewController {

    @IBOutlet weak var artistImage: UIImageView!
    
    @IBOutlet weak var playPauseButtonOutlet: UIButton!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var viewModel: ArtistItemDetailViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.getArtistInfo()
        bindViewModel()
        setupUI()
    }
    
    private func setupUI() {
        tableView.dataSource = self
        tableView.delegate = self
        let itemDetailNib = UINib(nibName: "TrackItemDetailTableViewCell", bundle: nil)
        tableView.register(itemDetailNib, forCellReuseIdentifier: "TrackItemDetailTableViewCell")
    }
    
    private func bindViewModel() {
        viewModel?.updateClosure = { [weak self] in
            guard let self = self else { return }
            guard let imageURL = viewModel?.artist?.images?.first?.url,
                  let artistName = viewModel?.artist?.name
            else { return }
            artistNameLabel.text = artistName
            artistImage.webImage(url: imageURL)
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
    func numberOfSections(in tableView: UITableView) -> Int {
        4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            case 0:
                return viewModel?.topTracks.count ?? 0
            default:
                return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
            case 0:
                guard let trackCell = tableView.dequeueReusableCell(withIdentifier: "TrackItemDetailTableViewCell") as? TrackItemDetailTableViewCell else { return UITableViewCell() }
                guard let artist = viewModel?.topTracks[indexPath.row].artists?.first?.name,
                      let track = viewModel?.topTracks[indexPath.row].name,
                      let url = viewModel?.topTracks[indexPath.row].album?.images?.first?.url else { return trackCell }
                trackCell.configure(track: track, artist: artist, image: url)
                return trackCell
            case 1:
                return UITableViewCell()
            case 2:
                return UITableViewCell()
            default:
                return UITableViewCell()
        }
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

