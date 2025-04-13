import UIKit

public struct LoginViewModel {
    public let emailPlaceholder: String
    public let passwordPlaceholder: String
    public let loginButtonTitle: String
    public let errorMessage: String?
    
    public init(
        emailPlaceholder: String,
        passwordPlaceholder: String,
        loginButtonTitle: String,
        errorMessage: String? = nil
    ) {
        self.emailPlaceholder = emailPlaceholder
        self.passwordPlaceholder = passwordPlaceholder
        self.loginButtonTitle = loginButtonTitle
        self.errorMessage = errorMessage
    }
}

public class LoginView: UIView {
    private let emailField: TextInputProtocol
    private let emailError: LabelProtocol
    private let passwordField: TextInputProtocol
    private let loginButton: ButtonProtocol
    private let stackView: StackViewProtocol
    
    public var emailText: String? { (emailField as! UITextField).text }
    public var passwordText: String? { (passwordField as! UITextField).text }
    public var emailTextField: TextInputProtocol { emailField }
    public var loginButtonView: ButtonProtocol { loginButton }
    
    public init(viewModel: LoginViewModel) {
        emailField = DesignSystem.textInput(viewModel: .init(style: .email, placeholder: viewModel.emailPlaceholder))
        emailError = DesignSystem.label(viewModel: .init(style: .error, text: viewModel.errorMessage, isHidden: viewModel.errorMessage == nil))
        passwordField = DesignSystem.textInput(viewModel: .init(style: .secure, placeholder: viewModel.passwordPlaceholder))
        loginButton = DesignSystem.button(viewModel: .init(style: .indigoType, title: viewModel.loginButtonTitle))
        stackView = DesignSystem.stackView(axis: .vertical, spacing: Space.xs)
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .white
        
        let stackView = self.stackView as! UIStackView
        stackView.addArrangedSubview(emailField as UIView)
        stackView.addArrangedSubview(emailError as UIView)
        stackView.addArrangedSubview(passwordField as UIView)
        stackView.addArrangedSubview(loginButton as UIView)
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Space.m),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Space.s)
        ])
    }
    
    public func configure(with viewModel: LoginViewModel) {
        emailField.configure(with: .init(style: .email, placeholder: viewModel.emailPlaceholder, text: (emailField as! UITextField).text))
        emailError.configure(with: .init(style: .error, text: viewModel.errorMessage, isHidden: viewModel.errorMessage == nil))
        passwordField.configure(with: .init(style: .secure, placeholder: viewModel.passwordPlaceholder, text: (passwordField as! UITextField).text))
        loginButton.configure(with: .init(style: .indigoType, title: viewModel.loginButtonTitle))
    }
}
