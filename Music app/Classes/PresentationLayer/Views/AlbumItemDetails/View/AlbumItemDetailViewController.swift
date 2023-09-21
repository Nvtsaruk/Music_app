import UIKit
import SDWebImage

final class AlbumItemDetailViewController: UIViewController {
    //MARK: -IBOutlets
    
    @IBOutlet var albumImageOutlet: UIImageView!
    
    @IBOutlet var albumTitleLabel: UILabel!
    @IBOutlet var artistNameLabel: UILabel!
    @IBOutlet var typeAndYearLabel: UILabel!
    
    @IBOutlet var playPauseButtonOutlet: UIButton!
    
    @IBOutlet var tableView: UITableView!
    //MARK: -Variables
    
    var viewModel: AlbumItemDetailViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.getAlbumItems()
        setupUI()
        bindViewModel()
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
            guard let url = viewModel?.album.images?.first?.url else { return }
                self.albumImageOutlet.webImage(url: url)
            if let imageCached = SDImageCache.shared.imageFromMemoryCache(forKey: url) {
                var colorTop = imageCached.findAverageColor()?.cgColor ?? CGColor(red: 1, green: 1, blue: 1, alpha: 1)
                let colors = Colors(colorTop: colorTop, colorBottom: CGColor(gray: 0, alpha: 1))
                view.backgroundColor = UIColor.clear
                let backgroundLayer = colors.gl
                backgroundLayer?.frame = view.frame
                view.layer.insertSublayer(backgroundLayer ?? CAGradientLayer(), at: 0)
            }
            if self.viewModel?.isPlaying == true {
                self.playPauseButtonOutlet.setImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
            } else {
                self.playPauseButtonOutlet.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
            }
//            descriptionLabel.text = viewModel?.details
            tableView.reloadData()
            albumTitleLabel.text = viewModel?.album.name
            artistNameLabel.text = viewModel?.album.tracks.items.first?.artists?.first?.name
            typeAndYearLabel.text = viewModel?.album.release_date ?? ""
        }
    }
    
    @IBAction func playPauseButtonAction(_ sender: Any) {
        viewModel?.playButtonAction()
    }
}

extension AlbumItemDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.album.tracks.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TrackItemDetailTableViewCell") as? TrackItemDetailTableViewCell else { return UITableViewCell() }
        guard let artist = viewModel?.album.tracks.items[indexPath.row].artists?.first?.name,
              let track = viewModel?.album.tracks.items[indexPath.row].name,
              let url = viewModel?.album.images?.first?.url
        else { return cell}
        cell.configure(track: track, artist: artist, image: url)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.addPlayItems(itemIndex: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension AlbumItemDetailViewController: Storyboarded {
    static func containingStoryboard() -> Storyboard {
        .AlbumItemDetail
    }
}
