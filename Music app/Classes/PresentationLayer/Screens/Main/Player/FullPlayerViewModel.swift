import Foundation
import CoreMedia
protocol FullPlayerViewModelProtocol: PlayerViewModelProtocol {
    func nextItem()
    func previousItem()
    func getSongLength() -> String
    var currentPosition: String { get }
    func getCurrentPlaybackTime()
    func updatePlaybackTime()
    func getSliderPosition() -> Float
    func stopTimer()
    func setPlaybackTime(time: Float)
}
class FullPlayerModel: PlayerViewModel, FullPlayerViewModelProtocol {
    var playbackTimer: Timer?
    
    var currentPosition: String = ""{
        didSet {
            updatePlayerState?()
        }
    }
    
    func updatePlaybackTime() {
        playbackTimer?.invalidate()
        playbackTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: false)
    }
    
    @objc private func updateTime() {
        getCurrentPlaybackTime()
        getSliderPosition()
    }
    
    func stopTimer() {
        playbackTimer?.invalidate()
    }
    
    func setPlaybackTime(time: Float) {
        AudioPlayerService.shared.player.seek(to: CMTime(seconds: Double(time * 30), preferredTimescale: 30), toleranceBefore: CMTime(seconds: 1, preferredTimescale: 30), toleranceAfter: CMTime(seconds: 1, preferredTimescale: 30)) {_ in
            self.updatePlaybackTime()
        }
    }
    
    func getSongLength() -> String {
        guard let duration = AudioPlayerService.shared.player.currentItem?.duration.seconds else { return "" }
        
        let length = getTime(time: duration)
        return length
    }
    
    func getCurrentPlaybackTime() {
        guard let currentPlaybackTime = AudioPlayerService.shared.player.currentItem?.currentTime().seconds else { return }
        
        currentPosition = getTime(time: currentPlaybackTime)
        
    }

    func getSliderPosition() -> Float {
        guard let duration = AudioPlayerService.shared.player.currentItem?.duration.seconds else { return 0 }
        guard let currentPlaybackTime = AudioPlayerService.shared.player.currentItem?.currentTime().seconds else { return 0}
        let position = currentPlaybackTime / duration
        if round(currentPlaybackTime) == round(duration) {
            nextItem()
        }
        return Float(position)
    }
    
    private func getTime(time: Double) -> String {
        var timeString: String = ""
        if round(time) < 60 {
            if round(time) < 10 {
                timeString = "0:0\(Int(round(time)))"
            } else {
                timeString = "0:\(Int(round(time)))"
            }
        }
        return timeString
    }
    
    func nextItem() {
        AudioPlayerService.shared.nextItem()
    }
    
    func previousItem() {
        AudioPlayerService.shared.previousItem()
    }
}
