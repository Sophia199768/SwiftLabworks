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
        loginView = LoginView(viewModel: .init(
            emailPlaceholder: "Email",
            passwordPlaceholder: "Password",
            loginButtonTitle: "Login"
        ))
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        (loginView.emailTextField as! UITextField).addTarget(self, action: #selector(emailTextChanged(_:)), for: .editingChanged)
        (loginView.loginButtonView as! UIButton).addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    @objc func emailTextChanged(_ textField: UITextField) {
        guard let email = textField.text else {
            loginView.configure(with: .init(
                emailPlaceholder: "Email",
                passwordPlaceholder: "Password",
                loginButtonTitle: "Login",
                errorMessage: "Email is empty"
            ))
            return
        }
        if authService.validateInput(email: email) {
            loginView.configure(with: .init(
                emailPlaceholder: "Email",
                passwordPlaceholder: "Password",
                loginButtonTitle: "Login",
                errorMessage: nil
            ))
        } else {
            loginView.configure(with: .init(
                emailPlaceholder: "Email",
                passwordPlaceholder: "Password",
                loginButtonTitle: "Login",
                errorMessage: "Invalid email format"
            ))
        }
    }
    
    @objc func loginButtonTapped() {
        guard let email = loginView.emailText, let password = loginView.passwordText else {
            loginView.configure(with: .init(
                emailPlaceholder: "Email",
                passwordPlaceholder: "Password",
                loginButtonTitle: "Login",
                errorMessage: "Please fill all fields"
            ))
            return
        }
        let authorizationDto = AuthorizationDto(email: email, password: password)
        
        if authService.validateInput(email: email) {
            let success = authService.login(authorizationDto: authorizationDto)
            if success {
                router.showListOfUniversities(from: self)
            } else {
                loginView.configure(with: .init(
                    emailPlaceholder: "Email",
                    passwordPlaceholder: "Password",
                    loginButtonTitle: "Login",
                    errorMessage: "Login failed"
                ))
            }
        } else {
            loginView.configure(with: .init(
                emailPlaceholder: "Email",
                passwordPlaceholder: "Password",
                loginButtonTitle: "Login",
                errorMessage: "Please enter a valid email"
            ))
        }
    }
}
