import UIKit

class LoginController: UIViewController, LoginControllerProtocol {
    private var loginView: LoginView!
    private let authService: AuthorizationService
    private let router: Router
    
    init(authService: AuthorizationService, router: Router) {
        self.authService = authService
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        loginView = LoginView()
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.emailField.addTarget(self, action: #selector(emailTextChanged(_:)), for: .editingChanged)
        loginView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    @objc func emailTextChanged(_ textField: UITextField) {
        guard let email = textField.text else { return }
        if authService.validateInput(email: email) {
            loginView.emailField.layer.borderColor = UIColor.clear.cgColor
            loginView.emailError.isHidden = true
        } else {
            loginView.emailField.layer.borderColor = UIColor.red.cgColor
            loginView.emailField.layer.borderWidth = 1.0
            loginView.emailError.text = "Invalid email format"
            loginView.emailError.isHidden = false
        }
    }
    
    @objc func loginButtonTapped() {
        guard let email = loginView.emailField.text, let password = loginView.passwordField.text else { return }
        let authorizationDto = AuthorizationDto(email: email, password: password)
        
        if authService.validateInput(email: email) {
            let success = authService.login(authorizationDto: authorizationDto)
            if success {
                router.showListOfUniversities(from: self)
            } else {
                loginView.emailError.text = "Login failed"
                loginView.emailError.isHidden = false
            }
        } else {
            loginView.emailError.text = "Please enter a valid email"
            loginView.emailError.isHidden = false
        }
    }
}
