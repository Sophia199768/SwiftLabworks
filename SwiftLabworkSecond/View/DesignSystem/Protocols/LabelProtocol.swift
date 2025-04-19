import UIKit

public protocol LabelProtocol: UIView {
    var text: String? { get set }
    var isHidden: Bool { get set }
    func configure(with viewModel: LabelViewModel)
}
