import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        let userRepository = UserRepositoryImpl()
        let networkService = AuthNetworkService()
        let authService = AuthorizationServiceImpl(userRepository: userRepository, userNetwork: networkService)
        let loginVC = LoginController(authService: authService)
        let navigationController = UINavigationController(rootViewController: loginVC)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
