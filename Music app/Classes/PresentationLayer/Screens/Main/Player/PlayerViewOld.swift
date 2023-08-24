//import UIKit
//
//protocol PlayerViewProtocol {
//    var contentView: UIView! { get }
//
//    func commonInit(for playerViewName: String)
//}
//extension PlayerViewProtocol where Self: UIView {
//    func commonInit(for playerViewName: String) {
//        Bundle.main.loadNibNamed(playerViewName, owner: self)
//        addSubview(contentView)
//        contentView.backgroundColor = .white
//        contentView.frame = bounds
//        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//    }
//}
//final class PlayerView: UIView, PlayerViewProtocol {
//    var playing: Bool = false
//    @IBOutlet weak var playButton: UIButton!
//    @IBOutlet weak var container: UIView!
//    @IBOutlet weak var artistName: UILabel!
//    @IBOutlet weak var trackName: UILabel!
//    @IBOutlet weak var trackImage: UIImageView!
//    @IBOutlet var contentView: UIView!
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        commonInit(for: "PlayerView")
//    }
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        commonInit(for: "PlayerView")
//        setupUI()
//    }
//
//    private func setupUI() {
//        container.layer.cornerRadius = 8
//        container.clipsToBounds = true
//        trackImage.layer.cornerRadius = 8
//        guard let url = URL(string: "https://charts-images.scdn.co/assets/locale_en/viral/daily/region_global_large.jpg") else { return }
//        trackImage.sd_setImage(with: url, placeholderImage: .checkmark)
//    }
//
//    @IBAction func playButtonAction(_ sender: Any) {
//        if playing == false {
//            playButton.setImage(UIImage(systemName: "pause"), for: .normal)
//            playing = true
//        } else {
//            playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
//            playing = false
//        }
//    }
//
//
//}


