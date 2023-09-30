import Foundation
enum ProfileLocalization {
    case myProfile
    case logout
    case plan
    case email
    case userID
    case country
    
    var string: String {
        switch self {
            case .myProfile:
                return NSLocalizedString("myProfile", comment: "")
            case .logout:
                return NSLocalizedString("logout", comment: "")
            case .plan:
                return NSLocalizedString("plan", comment: "")
            case .email:
                return NSLocalizedString("email", comment: "")
            case .userID:
                return NSLocalizedString("userID", comment: "")
            case .country:
                return NSLocalizedString("country", comment: "")
        }
    }
}

