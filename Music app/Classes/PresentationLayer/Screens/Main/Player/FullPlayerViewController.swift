import UIKit
import SDWebImage
final class FullPlayerViewController: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet private weak var albumImage: UIImageView!
    
    @IBOutlet private weak var backgroundImage: UIImageView!
    @IBOutlet private weak var trackNameLabel: UILabel!
    @IBOutlet private weak var songLengthLabel: UILabel!
    @IBOutlet private weak var currentPlaybackTimeLabel: UILabel!
    @IBOutlet private weak var artistNameLabel: UILabel!
    
    @IBOutlet private weak var playbackPositionSlider: UISlider!
    
    @IBOutlet private weak var playPauseButtonOutlet: UIButton!
    
    //MARK: - Variables
    var viewModel: FullPlayerViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUpdateClosure()
        bindViewModel()
        viewModel?.initPlayer()
        albumImage.webImage(url: viewModel?.playerItemData?.imageURL ?? "")
        trackNameLabel.text = viewModel?.playerItemData?.trackName
        viewModel?.getCurrentPlaybackTime()
        setupUI()
    }
    
    private func setupUI() {
        setBackground()
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        navigationController?.navigationBar.topItem?.leftBarButtonItem?.tintColor = .white
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    private func bindUpdateClosure() {
        viewModel?.updateClosure = { [weak self] in
            guard let self = self else { return }
            guard let url = viewModel?.playerItemData?.imageURL else { return }
            albumImage.webImage(url: url)
            setBackground()
            trackNameLabel.text = viewModel?.playerItemData?.trackName
            artistNameLabel.text = viewModel?.playerItemData?.artistName
            self.songLengthLabel.text = self.viewModel?.getSongLength()
        }
    }
    private func setBackground() {
        guard let image = self.albumImage.image?.cgImage else { return }
        print(image)
        let inputImage = CIImage(cgImage: image)
        let filter = CIFilter(name: "CIGaussianBlur")
        filter?.setValue(inputImage, forKey: "inputImage")
        filter?.setValue(50, forKey: "inputRadius")
        let blurred = filter?.outputImage
        self.backgroundImage.image = UIImage(ciImage: blurred!)
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
            self.currentPlaybackTimeLabel.text = self.viewModel?.currentPosition
        }
    }
    
    @IBAction private func playbackPositionSliderAction(_ sender: Any) {
        viewModel?.stopTimer()
        
        viewModel?.setPlaybackTime(time: playbackPositionSlider.value)
    }
    @IBAction private func previousButtonAction(_ sender: Any) {
        viewModel?.previousItem()
    }
    @IBAction private func nextButtonAction(_ sender: Any) {
        viewModel?.nextItem()
    }
    @IBAction private func playPauseButtonAction(_ sender: Any) {
        viewModel?.playPauseButtonAction()
    }
    @IBAction private func backButton(_ sender: Any) {
        dismiss(animated: true)
        viewModel?.showCompactPlayer()
    }
}

extension FullPlayerViewController: Storyboarded {
    static func containingStoryboard() -> Storyboard {
        .FullPlayer
    }
}
