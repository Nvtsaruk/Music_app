import AVKit
import SDWebImage

protocol AudioPlayerDelegate: AnyObject {
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
    
    var delegate: AudioPlayerDelegate?
    var showHideDelegate: AudioPlayerShowHideDelegate?
    var playerItem: [PlayerItemModel?] = []
    var isPlaying: Bool = false
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
    
    func addPlaylistForPlayer(_ item: PlaylistModel, itemIndex: Int) {
        self.playerItem = []
        item.tracks?.items?.forEach { item in
            guard let url = item.track?.preview_url else { return }
            guard let imageUrl = item.track?.album?.images?.first?.url else { return }
            guard let trackName = item.track?.name else { return }
            guard let artistName = item.track?.artists?.first?.name else { return }
            let playerItem = PlayerItemModel(url: url, image: imageUrl, trackName: trackName, artistName: artistName)
            self.playerItem.append(playerItem)
        }
        self.itemIndex = itemIndex
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
