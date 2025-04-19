import UIKit

internal class StackView: UIStackView, StackViewProtocol {
    init(
        axis: NSLayoutConstraint.Axis,
        spacing: CGFloat = Space.s,
        arrangedSubviews: [UIView] = []
    ) {
        super.init(frame: .zero)
        self.axis = axis
        self.spacing = spacing
        self.translatesAutoresizingMaskIntoConstraints = false
        arrangedSubviews.forEach { addArrangedSubview($0) }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:)")
    }
}
