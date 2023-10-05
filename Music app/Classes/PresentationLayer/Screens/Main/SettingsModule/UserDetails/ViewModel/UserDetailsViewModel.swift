protocol UserDetailsViewModelProtocol {
    var currentUser: UserProfile? { get }
}

final class UserDetailsViewModel: UserDetailsViewModelProtocol {
    var coordinator: MainPageCoordinator?
    var currentUser: UserProfile?
}
