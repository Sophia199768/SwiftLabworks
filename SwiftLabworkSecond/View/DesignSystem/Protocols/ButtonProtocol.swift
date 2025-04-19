import UIKit

public protocol ButtonProtocol: UIView {
    func setTitle(_ title: String?, for state: UIControl.State)
    func configure(with viewModel: ButtonViewModel)
}
