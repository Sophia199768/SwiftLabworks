import UIKit

protocol Router {
    func showLogin(from window: UIWindow?)
    func showListOfUniversities(from viewController: UIViewController)
}

class AppRouter: Router {
    func showLogin(from window: UIWindow?) {
        let userRepository = UserRepositoryImpl()
        let networkService = AuthNetworkService()
        let authService = AuthorizationServiceImpl(userRepository: userRepository, userNetwork: networkService)
        let loginViewController = LoginController(authService: authService, router: self)
        let navigationController = UINavigationController(rootViewController: loginViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func showListOfUniversities(from viewController: UIViewController) {
        let viewModel = UniversityViewModel()
        let universityViewController = UniversityListController(viewModel: viewModel, router: self)
        viewController.navigationController?.pushViewController(universityViewController, animated: true)
    }
}
