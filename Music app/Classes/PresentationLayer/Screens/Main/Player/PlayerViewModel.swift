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

class PlayerViewModel: PlayerViewModelProtocol, AudioPlayerServiceObserver {
    func audioPlayerPlaying(item: PlayerItemModel) {
        isPlaying = true
        self.playerItemData = item
        updatePlayerState?()
    }
    
    func audioPlayerPaused(item: PlayerItemModel) {
        isPlaying = false
        self.playerItemData = item
        updatePlayerState?()
    }
    
    func audioPlayerDidStop() {
        
    }

    weak var delegate: PlayerViewModelDelegate?
    var playerItemData: PlayerItemModel? {
        didSet {
            updatePlayerState?()
        }
    }
    
    func sendTrackInfo(playerItem: PlayerItemModel) {
        self.playerItemData = playerItem
    }
    
    
    func initPlayer() {
        AudioPlayerService.shared.addObserver(self)
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
