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

class PlayerViewModel: PlayerViewModelProtocol, AudioPlayerDelegate {
    
    
    var playerItemData: PlayerItemModel? {
        didSet {
            updatePlayerState?()
        }
    }
    
    
    func audioPlayerDidStartPlaying() {
        isPlaying = true
    }
    
    func audioPlayerDidStopPlaying() {
        isPlaying = false
    }
    
    func sendTrackInfo(playerItem: PlayerItemModel) {
        self.playerItemData = playerItem
    }
    
    
    
    func initPlayer() {
        AudioPlayerService.shared.delegate = self
        AudioPlayerService.shared.initPlayerData()
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
