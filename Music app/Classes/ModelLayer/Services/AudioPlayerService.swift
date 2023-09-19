import AVKit
import SDWebImage

protocol AudioPlayerDelegate: AnyObject {
    func audioPlayerDidStartPlaying()
    func audioPlayerDidStopPlaying()
    func sendTrackInfo(playerItem: PlayerItemModel)
}
protocol AudioPlayerDelegateForDetails: AnyObject {
    func audioPlayerDidStartPlaying()
    func audioPlayerDidStopPlaying()
    func sendTrackInfo(playerItem: PlayerItemModel)
}

protocol AudioPlayerShowHideDelegate: AnyObject {
    func showCompactPlayer()
    func showFullPlayer()
}



final class AudioPlayerService {
    static var shared = AudioPlayerService()
    private init() {}
    
    var player: AVPlayer? = AVPlayer()
    
    weak var delegate: AudioPlayerDelegate?
    weak var detailsDelegate: AudioPlayerDelegateForDetails?
    weak var showHideDelegate: AudioPlayerShowHideDelegate?
    var playerItem: [PlayerItemModel?] = []
    var isPlaying: Bool = false {
        didSet {
            if isPlaying {
                detailsDelegate?.audioPlayerDidStartPlaying()
            } else {
                detailsDelegate?.audioPlayerDidStopPlaying()
            }
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
            guard let urlString = playerItem[itemIndex]?.url else { return }
            guard let url = URL(string: urlString) else { return }
            play(url: url)
            if compactPlayerPresented == false {
                presentCompactPlayer()
                compactPlayerPresented = true
            }
            guard let playerItem = playerItem[itemIndex] else { return }
            delegate?.sendTrackInfo(playerItem: playerItem)
        }
    }
    
    func addPlaylistForPlayer(_ item: [PlayerItemModel], itemIndex: Int) {
        self.playerItem = []
        self.playerItem = item
        self.itemIndex = itemIndex
        initPlayerData()
    }
    
    func initPlayerData() {
        delegate?.sendTrackInfo(playerItem: playerItem[itemIndex] ?? PlayerItemModel())
    }
    
    func play(url:URL) {
        let playerItem = AVPlayerItem(url: url)
        
        self.player = AVPlayer(playerItem:playerItem)
        player?.volume = 1.0
        player?.play()
        isPlaying = true
        delegate?.audioPlayerDidStartPlaying()
        
    }
    func playPause() {
        if isPlaying == true {
            player?.pause()
            isPlaying = false
            delegate?.audioPlayerDidStopPlaying()
        } else {
            player?.play()
            isPlaying = true
            delegate?.audioPlayerDidStartPlaying()
        }
        
    }
    
    func nextItem() {
        itemIndex += 1
        guard let playerItem = playerItem[itemIndex] else { return }
        delegate?.sendTrackInfo(playerItem: playerItem)
    }
    
    func previousItem() {
        itemIndex -= 1
        guard let playerItem = playerItem[itemIndex] else { return }
        
        delegate?.sendTrackInfo(playerItem: playerItem)
    }
    
    func presentCompactPlayer() {
        showHideDelegate?.showCompactPlayer()
    }
    
    func presentFullPlayer() {
        showHideDelegate?.showFullPlayer()
    }
}
