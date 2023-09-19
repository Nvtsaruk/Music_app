import CoreMedia
protocol PlayerViewModelProtocol {
    var isPlaying: Bool { get set }
    func playPauseButtonAction()
    var updatePlayerState: (() -> Void)? { get set }
    func showFullPlayer()
    func showCompactPlayer()
    func initPlayer()
    var playerItemData: PlayerItemModel? { get }
    
    
    
}
protocol PlayerViewModelDelegate: AnyObject {
    func startPlaying()
    func stopPlaying()
}


class PlayerViewModel: PlayerViewModelProtocol, AudioPlayerDelegate {
    
    weak var delegate: PlayerViewModelDelegate?
    var playerItemData: PlayerItemModel? {
        didSet {
            updatePlayerState?()
        }
    }
    
    
    func audioPlayerDidStartPlaying() {
        isPlaying = true
        delegate?.startPlaying()
    }
    
    func audioPlayerDidStopPlaying() {
        isPlaying = false
        delegate?.stopPlaying()
    }
    
    func sendTrackInfo(playerItem: PlayerItemModel) {
        self.playerItemData = playerItem
    }
    
    
    
    func initPlayer() {
        AudioPlayerService.shared.delegate = self
        AudioPlayerService.shared.initPlayerData()
        isPlaying = AudioPlayerService.shared.isPlaying
    }
    
    var isPlaying: Bool = true {
        didSet {
            updatePlayerState?()
        }
    }
    var updatePlayerState: (() -> Void)?
    func playPauseButtonAction() {
        AudioPlayerService.shared.playPause()
    }
    func showFullPlayer() {
        AudioPlayerService.shared.presentFullPlayer()
    }
    func showCompactPlayer() {
        AudioPlayerService.shared.presentCompactPlayer()
    }
}
