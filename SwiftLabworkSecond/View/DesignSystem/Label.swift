import UIKit

public enum LabelStyle {
    case head
    case body
    case error
}

internal class Label: UILabel, LabelProtocol {
    private let style: LabelStyle
    
    init(viewModel: LabelViewModel) {
        self.style = viewModel.style
        super.init(frame: .zero)
        configure(with: viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    func configure(with viewModel: LabelViewModel) {
        guard viewModel.style == style else { return }
        text = viewModel.text
        isHidden = viewModel.isHidden
        switch viewModel.style {
        case .head:
            font = .systemFont(ofSize: 28, weight: .bold)
            textColor = .black
        case .body:
            font = .systemFont(ofSize: 16, weight: .regular)
            textColor = .darkGray
        case .error:
            font = .systemFont(ofSize: 12, weight: .regular)
            textColor = .systemRed
        }
        numberOfLines = 0
        translatesAutoresizingMaskIntoConstraints = false
    }
}
