import UIKit

public struct AccountViewModel {
    public let name: String
    public let buttonTitle: String
    
    public init(name: String, buttonTitle: String) {
        self.name = name
        self.buttonTitle = buttonTitle
    }
}

public class AccountView: UIView {
    private let nameLabel: LabelProtocol
    private let logoutButton: ButtonProtocol
    private let stackView: StackViewProtocol
    
    public var logoutButtonView: ButtonProtocol { logoutButton }
    
    public init(viewModel: AccountViewModel) {
        nameLabel = DesignSystem.label(viewModel: .init(style: .body, text: viewModel.name))
        logoutButton = DesignSystem.button(viewModel: .init(style: .greenType, title: viewModel.buttonTitle))
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
        stackView.addArrangedSubview(nameLabel as UIView)
        stackView.addArrangedSubview(logoutButton as UIView)
        
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Space.m),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Space.m),
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Space.m)
        ])
    }
    
    public func configure(with viewModel: AccountViewModel) {
        nameLabel.configure(with: .init(style: .body, text: viewModel.name))
        logoutButton.configure(with: .init(style: .greenType, title: viewModel.buttonTitle))
    }
}
