// singleton
//class Singleton {
//    static var singleton = Singleton()
//    private init(){}
//}

import AVKit

protocol AudioPlayerDelegate: AnyObject {
    func audioPlayerDidStartPlaying()
    func audioPlayerDidStopPlaying()
    func sendTrackInfo(image: UIImage, track: String, artist: String)
}

protocol AudioPlayerShowHideDelegate: AnyObject {
    func showPlayer()
    func hidePlayer()
}

struct PlayerItemModel {
    var url: URL
    var image: UIImage
    var trackName: String
    var artistName: String
}

final class AudioPlayerService {
    static var shared = AudioPlayerService()
    private init() {}
    var player: AVPlayer? = AVPlayer()
    
    var delegate: AudioPlayerDelegate?
    var showHideDelegate: AudioPlayerShowHideDelegate?
    
    var isPlaying: Bool = false
    func addItemForPlayer(_ item: PlayerItemModel) {
        play(url: item.url)
        delegate?.sendTrackInfo(image: item.image, track: item.trackName, artist: item.artistName)
    }
    func play(url:URL) {
//        print("playing \(url)")
        let playerItem = AVPlayerItem(url: url)

        self.player = AVPlayer(playerItem:playerItem)
        player?.volume = 1.0
        player?.play()
        isPlaying = true
        delegate?.audioPlayerDidStartPlaying()
//        do {
//            
//        } catch let error as NSError {
//            self.player = nil
//            print(error.localizedDescription)
//        } catch {
//            print("AVAudioPlayer init failed")
//        }
    }
    func pause() {
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
}
