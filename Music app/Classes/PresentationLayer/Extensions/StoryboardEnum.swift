import UIKit

enum Storyboard: String {
    case Login
    case MainPage
    case SearchCategoriesPage
    case SearchPage
    case MyMediaPage
    case UserProfile
    case UserDetails
    case PlaylistItemDetail
    case TabBarController
    case FullPlayer
    case CategoriesDetails
    case AlbumItemDetail
    case ArtistItemDetail
    case AddToPlaylist
    
    var instance : UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T: UIViewController>() -> T {
        let identifier = String(describing: T.self)
        guard let viewController = self.instance.instantiateViewController(withIdentifier: identifier) as? T else {
            fatalError("Failed to instantiate view controller with identifier \(identifier)")
        }
        return viewController
    }
}
