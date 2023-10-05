import UIKit
import WebKit

final class LoginViewController: UIViewController, WKNavigationDelegate {

    var viewModel: LoginViewModelProtocol?
    
    private let webView: WKWebView = {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs
        let webView = WKWebView(frame: .zero, configuration: config)
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        view.addSubview(webView)
        guard let url = viewModel?.signInURL else { return }
        webView.load(URLRequest(url: url))
        hideWebView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        guard let url = webView.url else { return }
        let component = URLComponents(string: url.absoluteString)
        guard let code = component?.queryItems?.first(where: { $0.name == "code" })?.value else { return }
        viewModel?.loginCode = code
    }
    
    private func hideWebView() {
        viewModel?.updateClosure = { [weak self] in
            self?.webView.removeFromSuperview()
            DispatchQueue.main.async {
                self?.viewModel?.goToTabBar()
            }
        }
    }
}

extension LoginViewController: Storyboarded {
    static func containingStoryboard() -> Storyboard {
        return .Login
    }
}
