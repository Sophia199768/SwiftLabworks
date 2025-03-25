import UIKit

class LoginViewController: UIViewController {
    private let loginView = LoginView()
    private let authService: AuthorizationService
    
    init(authorizationService: AuthorizationService) {
        self.authService = authorizationService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Mistake")
    }
    
    override func loadView() {
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
        setupTextFieldDelegates()
    }
    
    private func setupActions() {
        loginView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    private func setupTextFieldDelegates() {
        loginView.loginTextField.delegate = self
        loginView.passwordTextField.delegate = self
    }
    
    @objc private func loginButtonTapped() {
        guard let email = loginView.loginTextField.text, !email.isEmpty,
              let password = loginView.passwordTextField.text, !password.isEmpty else {
            showAlert(message: "Please, full fill all fields")
            return
        }
        
        let authDto = AuthorizationDto(email: email, password: password)
        authenticateUser(with: authDto)
    }
    
    private func authenticateUser(with authDto: AuthorizationDto) {
        if (authService.login(authorizationDto: authDto)) {
            print("Entransed succseed: \(authDto.email)")
        } else {
            showAlert(message: "Not right email or пароль")
        }
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Mistake", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginView.loginTextField {
            loginView.passwordTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            loginButtonTapped()
        }
        return true
    }
}
