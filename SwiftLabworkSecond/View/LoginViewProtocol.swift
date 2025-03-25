
// View для странички авторизации
protocol LoginViewProtocol {
    func showLoad()
    func hideLoad()
    func showError(message: String)
    func clearInputFields()
    func setLoginButtonEnabled( isEnabled: Bool)
}
