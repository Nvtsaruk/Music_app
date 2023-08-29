protocol PlayerViewModelProtocol {
    var isPlaying: Bool { get set }
    func showInteraction()
    var updateClosure:(() -> Void)? { get set }
}

final class PlayerViewModel: PlayerViewModelProtocol {
    var isPlaying: Bool = true {
        didSet {
            print(isPlaying)
            updateClosure?()
        }
    }
    var updateClosure: (() -> Void)?
    func showInteraction() {
        print("Button CLicked")
    }
}
