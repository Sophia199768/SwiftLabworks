import UIKit

public struct SettingsViewModel {
    public let usernamePlaceholder: String
    public let buttonTitle: String
    
    public init(usernamePlaceholder: String, buttonTitle: String) {
        self.usernamePlaceholder = usernamePlaceholder
        self.buttonTitle = buttonTitle
    }
}

public class SettingsView: UIView {
    private let usernameField: TextInputProtocol
    private let saveButton: ButtonProtocol
    private let stackView: StackViewProtocol
    
    public var usernameText: String? { (usernameField as! UITextField).text }
    public var saveButtonView: ButtonProtocol { saveButton }
    
    public init(viewModel: SettingsViewModel) {
        usernameField = DesignSystem.textInput(viewModel: .init(style: .standard, placeholder: viewModel.usernamePlaceholder))
        saveButton = DesignSystem.button(viewModel: .init(style: .indigoType, title: viewModel.buttonTitle))
        stackView = DesignSystem.stackView(axis: .vertical, spacing: Space.s)
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .white
        
        let stackView = self.stackView as! UIStackView
        stackView.addArrangedSubview(usernameField as UIView)
        stackView.addArrangedSubview(saveButton as UIView)
        
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Space.s),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Space.s),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    public func configure(with viewModel: SettingsViewModel) {
        usernameField.configure(with: .init(style: .standard, placeholder: viewModel.usernamePlaceholder, text: (usernameField as! UITextField).text))
        saveButton.configure(with: .init(style: .indigoType, title: viewModel.buttonTitle))
    }
}
