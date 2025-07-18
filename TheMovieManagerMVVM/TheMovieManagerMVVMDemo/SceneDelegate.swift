import SwiftUI
import TheMovieManagerMVVM

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = scene as? UIWindowScene else { return }
    
        // Cria o ViewModel
        let viewModel = LoginViewModel()

        // Cria a View SwiftUI com o ViewModel
        let rootView = TheMovieManagerLoginView(viewModel: viewModel)

        // Embala na UIHostingController
              let window = UIWindow(windowScene: windowScene)
              window.rootViewController = UIHostingController(rootView: rootView)
              self.window = window
              window.makeKeyAndVisible()
    }
}
