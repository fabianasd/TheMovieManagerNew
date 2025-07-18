import UIKit
import TheMovieManagerVIPER

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = scene as? UIWindowScene else { return }
    

        let window = UIWindow(windowScene: windowScene)

        let rootVC = TheMovieManagerVIPERLoginRouter.configuredViewController()
        window.rootViewController = rootVC

        self.window = window
        window.makeKeyAndVisible()
    }
}
