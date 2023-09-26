
import UIKit

class FullPlayerViewController: UIViewController {
    
    var viewModel: FullPlayerViewModelProtocol?
    
    @IBOutlet weak var albumImage: UIImageView!
    
    @IBOutlet weak var trackNameLabel: UILabel!
    
    @IBOutlet weak var artistNameLabel: UILabel!
    
    @IBOutlet weak var playbackPositionSlider: UISlider!
    @IBOutlet weak var songLengthLabel: UILabel!
    @IBOutlet weak var currentPlaybackTimeLabel: UILabel!
    @IBOutlet weak var playPauseButtonOutlet: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        viewModel?.initPlayer()
        albumImage.webImage(url: viewModel?.playerItemData?.image ?? "")
        trackNameLabel.text = viewModel?.playerItemData?.trackName
        viewModel?.getCurrentPlaybackTime()
        setupUI()
    }
    
    private func setupUI() {
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        navigationController?.navigationBar.topItem?.leftBarButtonItem?.tintColor = .white
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    private func bindViewModel() {
        viewModel?.updatePlayerState = { [weak self] in
            guard let self = self else { return }
            if self.viewModel?.isPlaying == true {
                self.playPauseButtonOutlet.setImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
            } else {
                self.playPauseButtonOutlet.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
            }
            playbackPositionSlider.setValue(viewModel?.getSliderPosition() ?? 0, animated: false)
            viewModel?.updatePlaybackTime()
//            DispatchQueue.main.async {
//                self.albumImage.webImage(url: self.viewModel?.playerItemData?.image ?? "")
//            }
            albumImage.webImage(url: viewModel?.playerItemData?.image ?? "")
            trackNameLabel.text = viewModel?.playerItemData?.trackName
            artistNameLabel.text = viewModel?.playerItemData?.artistName
            self.songLengthLabel.text = self.viewModel?.getSongLength()
            
            self.currentPlaybackTimeLabel.text = self.viewModel?.currentPosition
        }
    }
    
    @IBAction func playbackPositionSliderAction(_ sender: Any) {
        viewModel?.stopTimer()
        
        viewModel?.setPlaybackTime(time: playbackPositionSlider.value)
    }
    @IBAction func previousButtonAction(_ sender: Any) {
        viewModel?.previousItem()
    }
    @IBAction func nextButtonAction(_ sender: Any) {
        viewModel?.nextItem()
    }
    @IBAction func playPauseButtonAction(_ sender: Any) {
        viewModel?.playPauseButtonAction()
    }
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true)
        viewModel?.showCompactPlayer()
    }
}

extension FullPlayerViewController: Storyboarded {
    static func containingStoryboard() -> Storyboard {
        .FullPlayer
    }
}
