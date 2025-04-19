import UIKit

public enum DesignSystem {
    public static func label(viewModel: LabelViewModel) -> LabelProtocol {
        Label(viewModel: viewModel)
    }
    
    public static func button(viewModel: ButtonViewModel) -> ButtonProtocol {
        Button(viewModel: viewModel)
    }
    
    public static func textInput(viewModel: TextInputViewModel) -> TextInputProtocol {
        TextInput(viewModel: viewModel)
    }
    
    public static func stackView(
        axis: NSLayoutConstraint.Axis,
        spacing: CGFloat = Space.s,
        arrangedSubviews: [UIView] = []
    ) -> StackViewProtocol {
        StackView(axis: axis, spacing: spacing, arrangedSubviews: arrangedSubviews)
    }
}
