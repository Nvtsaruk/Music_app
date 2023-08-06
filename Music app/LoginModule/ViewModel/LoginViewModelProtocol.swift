import Foundation
protocol LoginViewModelProtocol {
    var signInURL: URL? { get }
    var loginCode: String { get set }
    var updateClosure: (() -> Void)? { get set }
}
