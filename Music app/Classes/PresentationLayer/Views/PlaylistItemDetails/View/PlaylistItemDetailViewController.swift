import UIKit
import SDWebImage

final class PlaylistItemDetailViewController: UIViewController {
    
    //MARK: - IBOutlet
    @IBOutlet private weak var playButtonOutlet: UIButton!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var itemImage: UIImageView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    //MARK: - Variables
    var viewModel: PlaylistItemDetailViewModelProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.start()
        viewModel?.getItems()
        
        bindViewModel()
        setupUI()
    }
    
    private func setupUI() {
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = UIColor.white
        tableView.dataSource = self
        tableView.delegate = self
        
        itemImage.clipsToBounds = false
        itemImage.layer.shadowColor = UIColor.white.cgColor
        itemImage.layer.shadowOpacity = 0.2
        itemImage.layer.shadowRadius = 30
        
        descriptionLabel.text = viewModel?.details
        let itemDetailNib = UINib(nibName: "TrackItemDetailTableViewCell", bundle: nil)
        tableView.register(itemDetailNib, forCellReuseIdentifier: "TrackItemDetailTableViewCell")
        tableView.reloadData()
        guard let url = viewModel?.playlist?.images.first?.url else { return }
            self.itemImage.webImage(url: url)
    }
    
    private func bindViewModel() {
        viewModel?.updateClosure = { [weak self] in
            guard let self = self else { return }
            guard let url = viewModel?.playlist?.images.first?.url else { return }
                self.itemImage.webImage(url: url)
            if let imageCached = SDImageCache.shared.imageFromMemoryCache(forKey: url) {
                let colorTop = imageCached.findAverageColor()?.cgColor ?? CGColor(red: 1, green: 1, blue: 1, alpha: 1)
                let colors = Colors(colorTop: colorTop, colorBottom: CGColor(gray: 0, alpha: 1))
                view.backgroundColor = UIColor.clear
                let backgroundLayer = colors.gl
                backgroundLayer?.frame = view.frame
                view.layer.insertSublayer(backgroundLayer ?? CAGradientLayer(), at: 0)
            }
            if self.viewModel?.isPlaying == true {
                self.playButtonOutlet.setImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
            } else {
                self.playButtonOutlet.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
            }
            descriptionLabel.text = viewModel?.details
            tableView.reloadData()
            
        }
    }
    
    
    @IBAction private func playButtonAction(_ sender: Any) {
        viewModel?.playButtonAction()
    }
}

extension PlaylistItemDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.playlist?.tracks.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TrackItemDetailTableViewCell") as? TrackItemDetailTableViewCell else { return UITableViewCell() }
        cell.delegate = viewModel as? any TrackItemDetailTableViewCellDelegate
        guard let artist = viewModel?.playlist?.tracks.items?[indexPath.row].track.artists.first?.name,
              let track = viewModel?.playlist?.tracks.items?[indexPath.row].track.name,
              let url = viewModel?.playlist?.tracks.items?[indexPath.row].track.album.images.first?.url,
              let id = viewModel?.playlist?.tracks.items?[indexPath.row].track.id
        else { return cell }
        var showAddButton: Bool
        if let playlistID = viewModel?.id {
            showAddButton = true
        } else {
            showAddButton = false
        }
        cell.configure(track: track, artist: artist, image: url, id: id, showButton: showAddButton)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.addPlayItems(itemIndex: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    
    
}

extension PlaylistItemDetailViewController: Storyboarded {
    static func containingStoryboard() -> Storyboard {
        .PlaylistItemDetail
    }
}
