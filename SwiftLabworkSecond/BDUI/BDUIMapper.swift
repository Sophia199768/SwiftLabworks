import UIKit

public final class BDUIMapper: BDUIMapperProtocol {

    public init() {}

    public func map(from model: BDUIViewModel) -> UIView {
        guard let viewType = ViewTypeToken(rawValue: model.type) else {
            return UIView()
        }

        switch viewType {
        case .contentView:
            return configureContentView(model)
        case .stackView:
            return configureStackView(model)
        case .label:
            return configureLabel(model)
        case .button:
            return configureButton(model)
        case .textInput:
            return configureTextInput(model)
        }
    }

    private func configureContentView(_ model: BDUIViewModel) -> UIView {
        let view = UIView()
        if let backgroundColor = model.content.backgroundColor,
           let colorToken = ColorToken(rawValue: backgroundColor) {
            view.backgroundColor = colorToken.color
        }
        configureSubviews(for: view, subviews: model.subviews)
        return view
    }

    private func configureStackView(_ model: BDUIViewModel) -> UIView {
        let spacing = model.content.spacing.flatMap { SpaceToken(rawValue: $0)?.value } ?? Space.s
        let stackView = DesignSystem.stackView(axis: .vertical, spacing: spacing)
        configureSubviews(for: stackView, subviews: model.subviews)
        return stackView
    }

    private func configureLabel(_ model: BDUIViewModel) -> UIView {
        let text = model.content.text ?? ""
        let isHidden = model.content.isHidden ?? false
       
        let style: LabelStyleToken
        if let styleRaw = model.content.style, let validStyle = LabelStyleToken(rawValue: styleRaw.rawValue) {
            style = validStyle
        } else {
            style = .body
        }

        let viewModel = LabelViewModel(style: style, text: text, isHidden: isHidden)
        let label = DesignSystem.label(viewModel: viewModel)

        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.heightAnchor.constraint(greaterThanOrEqualToConstant: 48)
        ])
        return label
    }

    private func configureButton(_ model: BDUIViewModel) -> UIView {
        let title = model.content.text ?? "Button"
        let styleString = model.content.style?.rawValue
        let style = ButtonStyleToken.fromString(styleString)
        let viewModel = ButtonViewModel(style: style, title: title)
        let button = DesignSystem.button(viewModel: viewModel)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 48)
        ])
        if let action = model.content.action {
            if action.type == "print" {
                (button as? UIButton)?.addAction(
                    UIAction { _ in print(action.context) },
                    for: .touchUpInside
                )
            }
        }
        return button
    }

    private func configureTextInput(_ model: BDUIViewModel) -> UIView {
        let placeholder = model.content.placeholder ?? ""
        let text = model.content.text
        let styleString = model.content.style?.rawValue
        let style = TextInputStyleToken.fromString(styleString)
        let viewModel = TextInputViewModel(style: style, placeholder: placeholder, text: text)
        let textInput = DesignSystem.textInput(viewModel: viewModel)
        return textInput
    }

    private func configureSubviews(for view: UIView, subviews: [BDUIViewModel]?) {
        guard let subviews = subviews, !subviews.isEmpty else { return }
        let stackView = view as? StackViewProtocol ?? {
            let stack = DesignSystem.stackView(axis: .vertical, spacing: Space.s)
            view.addSubview(stack)
            stack.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                stack.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor),
                stack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                stack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                stack.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor),
                stack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
            stack.setContentHuggingPriority(.required, for: .vertical)
            stack.setContentCompressionResistancePriority(.required, for: .vertical)
            return stack
        }()

        subviews.forEach { subviewModel in
            let subview = map(from: subviewModel)
            stackView.addArrangedSubview(subview)
        }
    }
}
