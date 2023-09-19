//
//  ItemDetailViewController.swift
//  Music app
//
//  Created by Tsaruk Nick on 17.08.23.
//

import UIKit
import SDWebImage

final class PlaylistItemDetailViewController: UIViewController {
    
    
    @IBOutlet weak var playButtonOutlet: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var viewModel: PlaylistItemDetailViewModelProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.getItems()
        descriptionLabel.text = viewModel?.details
        bindViewModel()
        setupUI()
    }
    
    private func setupUI() {
        tableView.dataSource = self
        tableView.delegate = self
        
        itemImage.clipsToBounds = false
        itemImage.layer.shadowColor = UIColor.white.cgColor
        itemImage.layer.shadowOpacity = 0.2
        itemImage.layer.shadowRadius = 30
        
        let itemDetailNib = UINib(nibName: "TrackItemDetailTableViewCell", bundle: nil)
        tableView.register(itemDetailNib, forCellReuseIdentifier: "TrackItemDetailTableViewCell")
    }
    
    private func bindViewModel() {
        viewModel?.updateClosure = { [weak self] in
            guard let self = self else { return }
            guard let url = viewModel?.playlist.images?.first?.url else { return }
            DispatchQueue.main.async {
                self.itemImage.webImage(url: url)
            }
            if let imageCached = SDImageCache.shared.imageFromMemoryCache(forKey: url) {
                var colorTop = imageCached.findAverageColor()?.cgColor ?? CGColor(red: 1, green: 1, blue: 1, alpha: 1)
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
    
    
    @IBAction func playButtonAction(_ sender: Any) {
        viewModel?.playButtonAction()
    }
    
}

extension PlaylistItemDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.playlist.tracks?.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TrackItemDetailTableViewCell") as? TrackItemDetailTableViewCell else { return UITableViewCell() }
        guard let artist = viewModel?.playlist.tracks?.items?[indexPath.row].track?.artists?.first?.name,
              let track = viewModel?.playlist.tracks?.items?[indexPath.row].track?.name,
              let url = viewModel?.playlist.tracks?.items?[indexPath.row].track?.album?.images?.first?.url else { return cell }
        cell.configure(track: track, artist: artist, image: url)
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
