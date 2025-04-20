import UIKit

public enum TextInputStyleToken {
    case standard
    case email
    case secure
}

internal class TextInput: UITextField, TextInputProtocol {
    private let style: TextInputStyleToken
    
    init(viewModel: TextInputViewModel) {
        self.style = viewModel.style
        super.init(frame: .zero)
        configure(with: viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    func configure(with viewModel: TextInputViewModel) {
        guard viewModel.style == style else { return }
        placeholder = viewModel.placeholder
        text = viewModel.text
        font = .systemFont(ofSize: 16)
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: Space.xs, height: 0))
        leftViewMode = .always
        translatesAutoresizingMaskIntoConstraints = false
        switch viewModel.style {
        case .standard:
            isSecureTextEntry = false
        case .email:
            isSecureTextEntry = false
            keyboardType = .emailAddress
            autocapitalizationType = .none
        case .secure:
            isSecureTextEntry = true
        }
        heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
}
