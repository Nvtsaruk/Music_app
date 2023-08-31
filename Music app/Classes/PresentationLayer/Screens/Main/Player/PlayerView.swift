
import UIKit

class PlayerView: UIView, AudioPlayerDelegate {
    func audioPlayerDidStartPlaying() {
        playButtonOutlet.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        print("Playing")
    }
    
    func audioPlayerDidStopPlaying() {
        print("Plause")
        playButtonOutlet.setImage(UIImage(systemName: "play.fill"), for: .normal)
    }
    func sendTrackInfo(image: UIImage, track: String, artist: String) {
        trackImage.image = image
        trackNameLabel.text = track
        artistNameLabel.text = artist
    }
    
    @IBOutlet weak var playButtonOutlet: UIButton!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var trackImage: UIImageView!
    @IBOutlet weak var container: UIView!
    
    var viewModel: PlayerViewModelProtocol?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.alpha = 0
        self.configureView()
        AudioPlayerService.shared.delegate = self
    }
    
    private func bindViewModel() {
        viewModel?.updateClosure = { [weak self] in
            self?.playButtonOutlet.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("In player")
        bindViewModel()
        AudioPlayerService.shared.delegate = self
    }
    
    
    private func configureView() {
        
        let subview = self.loadViewFromXib()
        subview.frame = self.bounds
        subview.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(subview)
        container.layer.cornerRadius = 8
        container.clipsToBounds = true
        trackImage.layer.cornerRadius = 8
        guard let url = URL(string: "https://charts-images.scdn.co/assets/locale_en/viral/daily/region_global_large.jpg") else { return }
        trackImage.sd_setImage(with: url, placeholderImage: .checkmark)
    }
    
    private func loadViewFromXib() -> UIView {
        guard let view = Bundle.main.loadNibNamed("PlayerView", owner: self)?.first as? UIView else { return UIView() }
        
        return view
    }
    
    
    @IBAction func playButtonAction(_ sender: Any) {
        AudioPlayerService.shared.pause()
    }
}
