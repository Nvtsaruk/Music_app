//
//  ItemDetailViewController.swift
//  Music app
//
//  Created by Tsaruk Nick on 17.08.23.
//

import UIKit
import SDWebImage
import AVKit

class ItemDetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var viewModel: ItemDetailViewModelProtocol?
    var player: AVPlayer?
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
        
        let itemDetailNib = UINib(nibName: "ItemDetailTableViewCell", bundle: nil)
        tableView.register(itemDetailNib, forCellReuseIdentifier: "ItemDetailTableViewCell")
    }
    
    private func bindViewModel() {
        viewModel?.updateClosure = { [weak self] in
            guard let self = self else { return }
            guard let url = viewModel?.playlist.images?.first?.url else { return }
            DispatchQueue.main.async {
                self.itemImage.sd_setImage(with: url, placeholderImage: .checkmark)
            }
            if let imageCached = SDImageCache.shared.imageFromMemoryCache(forKey: url.absoluteString) {
                var colorTop = imageCached.findAverageColor()?.cgColor ?? CGColor(red: 1, green: 1, blue: 1, alpha: 1)
                let colors = Colors(colorTop: colorTop, colorBottom: CGColor(gray: 0, alpha: 1))
                view.backgroundColor = UIColor.clear
                let backgroundLayer = colors.gl
                backgroundLayer?.frame = view.frame
                view.layer.insertSublayer(backgroundLayer ?? CAGradientLayer(), at: 0)
            }
            descriptionLabel.text = viewModel?.details
            tableView.reloadData()
            
        }
    }
    
    
    @IBAction func playButtonAction(_ sender: Any) {
    }
    
}

extension ItemDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.playlist.tracks?.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemDetailTableViewCell") as? ItemDetailTableViewCell else { return UITableViewCell() }
        cell.artistNameLabel.text = viewModel?.playlist.tracks?.items?[indexPath.row].track?.artists?.first?.name
        cell.trackNameLabel.text = viewModel?.playlist.tracks?.items?[indexPath.row].track?.name
        guard let url = viewModel?.playlist.tracks?.items?[indexPath.row].track?.album?.images?.first?.url else { return cell }
        cell.albumImage.sd_setImage(with: url, placeholderImage: .checkmark)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = viewModel?.playlist.tracks?.items?[indexPath.row].track?.preview_url else { return }
        play(url: url)
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func play(url:URL) {
        print("playing \(url)")

        do {
            let playerItem = AVPlayerItem(url: url)

            self.player = AVPlayer(playerItem:playerItem)
            player!.volume = 1.0
            player!.play()
        } catch let error as NSError {
            self.player = nil
            print(error.localizedDescription)
        } catch {
            print("AVAudioPlayer init failed")
        }
    }
    
}

extension ItemDetailViewController: Storyboarded {
    static func containingStoryboard() -> Storyboard {
        .ItemDetail
    }
}
