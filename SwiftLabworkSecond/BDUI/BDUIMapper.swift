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
        case .stack:
            return configureStackView(model)
        case .label:
            return configureLabel(model)
        case .button:
            return configureButton(model)
        case .textInput:
            return configureTextInput(model)
        case .image:
            return configureImage(model)
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
        let axis: NSLayoutConstraint.Axis = model.content.style == "vertical" ? .vertical : .horizontal
        let spacing = model.content.spacing.flatMap { SpaceToken(rawValue: $0)?.value } ?? Space.s
        let stackView = DesignSystem.stackView(axis: axis, spacing: spacing)
        configureSubviews(for: stackView, subviews: model.subviews)
        return stackView
    }

    private func configureLabel(_ model: BDUIViewModel) -> UIView {
        let text = model.content.text ?? ""
        let isHidden = model.content.isHidden ?? false
        let style = model.content.style.flatMap(LabelStyleToken.init(rawValue:)) ?? .body
        let viewModel = LabelViewModel(
            style: style,
            text: text,
            isHidden: isHidden,
            styleString: model.content.style
        )
        
        let label = DesignSystem.label(viewModel: viewModel)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    private func configureButton(_ model: BDUIViewModel) -> UIView {
        let title = model.content.text ?? "Button"
        let style = ButtonStyleToken.fromString(model.content.style)
        let viewModel = ButtonViewModel(style: style,title: title, action: model.content.action
        )
        
        let button = DesignSystem.button(viewModel: viewModel)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        return button
    }

    private func configureImage(_ model: BDUIViewModel) -> UIView {
        let viewModel = ImageViewModel(
            url: model.content.text,
            styleString: model.content.style,
            isHidden: model.content.isHidden
        )
        let imageView = DesignSystem.image(viewModel: viewModel)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }

    private func configureTextInput(_ model: BDUIViewModel) -> UIView {
        let placeholder = model.content.placeholder ?? ""
        let text = model.content.text
        let style = TextInputStyleToken.fromString(model.content.style)
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
                stack.topAnchor.constraint(equalTo: view.topAnchor),
                stack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                stack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                stack.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor)
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
