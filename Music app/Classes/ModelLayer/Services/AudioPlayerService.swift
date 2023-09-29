import AVKit
import SDWebImage

protocol AudioPlayerShowHideDelegate: AnyObject {
    func showCompactPlayer()
    func showFullPlayer()
}

protocol AudioPlayerServiceObserver: AnyObject {
    func audioPlayerPlaying(item: PlayerItemModel)
    func audioPlayerPaused(item: PlayerItemModel)
    func audioPlayerDidStop()
}
extension AudioPlayerServiceObserver {
    func audioPlayerPlaying(item: PlayerItemModel) {}
    func audioPlayerPaused(item: PlayerItemModel) {}
    func audioPlayerDidStop() {}
}

final class AudioPlayerService {
    static var shared = AudioPlayerService()
    private init() {}
    
    var player = AVPlayer()
    private var observations = [ObjectIdentifier : Observation]()
    weak var showHideDelegate: AudioPlayerShowHideDelegate?
    var playerItem: [PlayerItemModel] = []
    private var state = State.idle {
        didSet {
            stateDidChange()
        }
    }

    var compactPlayerPresented: Bool = false
    var itemIndex: Int = 0 {
        didSet {
            if itemIndex < 0 {
                itemIndex = playerItem.count - 1
            } else if itemIndex == playerItem.count {
                itemIndex = 0
            }
            let urlString = playerItem[itemIndex].url
            guard let url = URL(string: urlString) else { return }
            play(url: url)
            
            if compactPlayerPresented == false {
                presentCompactPlayer()
                compactPlayerPresented = true
            }
            let playerItem = playerItem[itemIndex]
            state = .playing(playerItem)
        }
    }
    
    func addPlaylistForPlayer(_ item: [PlayerItemModel], itemIndex: Int) {
        self.playerItem = []
        self.playerItem = item
        self.itemIndex = itemIndex
        initPlayerData()
    }
    
    func initPlayerData() {
        let playerItem = playerItem[itemIndex]
        state = .playing(playerItem)
    }
    
    func play(url:URL) {
        let playerItem = AVPlayerItem(url: url)
        self.player = AVPlayer(playerItem:playerItem)
        player.volume = 1.0
        player.play()
        
    }
    func playPause() {
        switch state {
            case .idle:
                break
            case .paused(let item):
                state = .playing(item)
                player.play()
            case .playing(let item):
                state = .paused(item)
                player.pause()
        }
    }
    
    func nextItem() {
        itemIndex += 1
//        let playerItem = playerItem[itemIndex]
    }
    
    func previousItem() {
        itemIndex -= 1
//        let playerItem = playerItem[itemIndex]
    }
    
    func presentCompactPlayer() {
        showHideDelegate?.showCompactPlayer()
    }
    
    func presentFullPlayer() {
        showHideDelegate?.showFullPlayer()
    }
}

private extension AudioPlayerService {
    struct Observation {
        weak var observer: AudioPlayerServiceObserver?
    }
}

private extension AudioPlayerService {
    enum State {
        case idle
        case playing(PlayerItemModel)
        case paused(PlayerItemModel)
    }
}

private extension AudioPlayerService {
    func stateDidChange() {
        for (id, observation) in observations {
                    guard let observer = observation.observer else {
                        observations.removeValue(forKey: id)
                        continue
                    }

                    switch state {
                    case .idle:
                        observer.audioPlayerDidStop()
                        case .playing(let item):
                        observer.audioPlayerPlaying(item: item)
                        case .paused(let item):
                        observer.audioPlayerPaused(item: item)
                    }
                }
    }
}
extension AudioPlayerService {
    func addObserver(_ observer: AudioPlayerServiceObserver) {
        let id = ObjectIdentifier(observer)
        observations[id] = Observation(observer: observer)
    }

    func removeObserver(_ observer: AudioPlayerServiceObserver) {
        let id = ObjectIdentifier(observer)
        observations.removeValue(forKey: id)
    }
}
