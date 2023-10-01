import UIKit
final class PlayerView: UIView {
    //MARK: - IBOutlet
    @IBOutlet private weak var playButtonOutlet: UIButton!
    @IBOutlet private weak var artistNameLabel: UILabel!
    @IBOutlet private weak var trackNameLabel: UILabel!
    @IBOutlet private weak var trackImage: UIImageView!
    @IBOutlet private weak var container: UIView!
    
    //MARK: - Variables
    var viewModel: PlayerViewModelProtocol?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.alpha = 0
        self.configureView()
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        bindViewModel()
        viewModel?.initPlayer()
    }
    
    private func bindViewModel() {
        viewModel?.updatePlayerState = { [weak self] in
            guard let self = self else { return }
            if self.viewModel?.isPlaying == true {
                self.playButtonOutlet.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            } else {
                self.playButtonOutlet.setImage(UIImage(systemName: "play.fill"), for: .normal)
            }
            
            self.trackImage.webImage(url: self.viewModel?.playerItemData?.imageURL ?? "")
            self.trackNameLabel.text = self.viewModel?.playerItemData?.trackName
            self.artistNameLabel.text = self.viewModel?.playerItemData?.artistName
        }
    }
    
    private func configureView() {
        let subview = self.loadViewFromXib()
        subview.frame = self.bounds
        subview.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(subview)
        container.layer.cornerRadius = 8
        container.clipsToBounds = true
        trackImage.layer.cornerRadius = 8
//        guard let url = URL(string: "https://charts-images.scdn.co/assets/locale_en/viral/daily/region_global_large.jpg") else { return }
//        trackImage.sd_setImage(with: url, placeholderImage: .checkmark)
        let didTap  = UITapGestureRecognizer(target: self, action: #selector(didTap))
        container.addGestureRecognizer(didTap)
    }
    @objc private func didTap() {
        viewModel?.showFullPlayer()
    }
    
    private func loadViewFromXib() -> UIView {
        guard let view = Bundle.main.loadNibNamed("PlayerView", owner: self)?.first as? UIView else { return UIView() }
        return view
    }
    
    
    @IBAction func playButtonAction(_ sender: Any) {
        viewModel?.playPauseButtonAction()
    }
}
