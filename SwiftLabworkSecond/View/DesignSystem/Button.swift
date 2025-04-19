import UIKit

public enum ButtonStyle {
    case indigoType
    case greenType
    case redType
}

internal class Button: UIButton, ButtonProtocol {
    private let style: ButtonStyle
    
    init(viewModel: ButtonViewModel) {
        self.style = viewModel.style
        super.init(frame: .zero)
        configure(with: viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    func configure(with viewModel: ButtonViewModel) {
        guard viewModel.style == style else { return }
        setTitle(viewModel.title, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        layer.cornerRadius = 12
        translatesAutoresizingMaskIntoConstraints = false
        switch viewModel.style {
        case .indigoType:
            backgroundColor = .systemIndigo
            setTitleColor(.white, for: .normal)
        case .greenType:
            backgroundColor = .clear
            setTitleColor(.systemGreen, for: .normal)
            layer.borderWidth = 2
            layer.borderColor = UIColor.systemGreen.cgColor
        case .redType:
            backgroundColor = .clear
            setTitleColor(.systemRed, for: .normal)
            layer.borderWidth = 2
            layer.borderColor = UIColor.systemRed.cgColor
        }
        heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
}
