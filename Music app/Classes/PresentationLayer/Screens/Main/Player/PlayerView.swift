
import UIKit

class PlayerView: UIView {
    
    @IBOutlet weak var playButtonOutlet: UIButton!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var trackImage: UIImageView!
    @IBOutlet weak var container: UIView!
    
    var viewModel: PlayerViewModelProtocol?
    var isPlaying: Bool = false {
        didSet {
            if isPlaying == false {
                playButtonOutlet.setImage(UIImage(systemName: "play.fill"), for: .normal)
            } else {
                playButtonOutlet.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            }
        }
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.alpha = 0
        self.configureView()
        print("Player in player", self)
        playerBehavior()
        
    }
    private func playerBehavior() {
        print("ViewModel:", viewModel)
        guard let playing = viewModel?.isPlaying else { return }
        print("playing1", playing)
        isPlaying = playing
    }
    private func bindViewModel() {
        viewModel?.updateClosure = { [weak self] in
            self?.playButtonOutlet.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bindViewModel()
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
        viewModel?.showInteraction()
        if isPlaying == true {
            
            isPlaying = false
            
        } else {
            
            isPlaying = true
        }
    }
}
