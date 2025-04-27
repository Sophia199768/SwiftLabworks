import UIKit

public struct ImageViewModel {
    let url: String?
    let styleString: String?
    let isHidden: Bool?
}

internal class ImageView: UIImageView, ImageProtocol {
    init(viewModel: ImageViewModel) {
        super.init(frame: .zero)
        configure(with: viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: ImageViewModel) {
        isHidden = viewModel.isHidden ?? false
        contentMode = .scaleAspectFit
        
        if let urlString = viewModel.url, let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                } else {
                    print("Failed")
                }
            }.resume()
        }
        
        var width: CGFloat?
        var height: CGFloat?
        if let styleString = viewModel.styleString {
            let components = styleString.split(separator: ";")
            for component in components {
                let parts = component.split(separator: ":")
                if parts.count == 2 {
                    let key = String(parts[0])
                    let value = String(parts[1])
                    if key == "width", let w = Float(value) {
                        width = CGFloat(w)
                    } else if key == "height", let h = Float(value) {
                        height = CGFloat(h)
                    }
                }
            }
        }
        
        if let width = width, let height = height {
            widthAnchor.constraint(equalToConstant: width).isActive = true
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}

extension DesignSystem {
    public static func image(viewModel: ImageViewModel) -> ImageProtocol {
        ImageView(viewModel: viewModel)
    }
}
