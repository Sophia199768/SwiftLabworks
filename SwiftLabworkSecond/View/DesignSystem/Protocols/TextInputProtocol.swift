import UIKit

public protocol TextInputProtocol: UIView {
    var text: String? { get set }
    var placeholder: String? { get set }
    func configure(with viewModel: TextInputViewModel)
}
