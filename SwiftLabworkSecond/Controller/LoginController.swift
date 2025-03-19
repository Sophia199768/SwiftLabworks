
class LoginController {
    var view: LoginViewProtocol?
    
    private let authorizationService: AuthorizationService
    
    init(authorizationService: AuthorizationService) {
        self.authorizationService = authorizationService
    }

    func login(username: String, password: String) {
        view?.showLoad()
        let authDto = AuthorizationDto(email: username, password: password)
        let isSuccess = authorizationService.login(authorizationDto: authDto)
        view?.hideLoad()

        if isSuccess {
            view?.clearInputFields()
        } else {
            view?.showError(message: "User with this login and password unexist! Try again or register")
            view?.setLoginButtonEnabled(isEnabled: true)
        }
    }

    func logOut() {
        authorizationService.logout()
        view?.clearInputFields()
    }
    
    func validateInput(username: String, password: String) {
        let isValid = !username.isEmpty && !password.isEmpty
        view?.setLoginButtonEnabled(isEnabled: isValid)
    }
}

