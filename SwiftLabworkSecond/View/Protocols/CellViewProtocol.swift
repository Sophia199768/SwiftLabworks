import UIKit

protocol ConfigurableView: UIView {
    associatedtype ViewModel
    func configure(with viewModel: ViewModel)
}

protocol ViewModel {
    associatedtype View: ConfigurableView where View.ViewModel == Self
}
