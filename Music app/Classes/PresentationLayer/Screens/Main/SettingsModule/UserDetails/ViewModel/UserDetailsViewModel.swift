protocol UserDetailsViewModelProtocol {
    var currentUser: UserProfile? { get }
//    var updateClosure: ( () -> Void )? { get set }
}

class UserDetailsViewModel: UserDetailsViewModelProtocol {
//    var updateClosure: (() -> Void)?
    var coordinator: MainPageCoordinator?
    var currentUser: UserProfile?

}
