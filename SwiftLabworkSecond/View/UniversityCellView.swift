import UIKit

class UniversityCellView: UIView, ConfigurableView {
    typealias ViewModel = UniversityCellViewModel
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let countryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let universityPictureView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let activityLoading: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(universityPictureView)
        addSubview(activityLoading)
        addSubview(nameLabel)
        addSubview(countryLabel)
        
        NSLayoutConstraint.activate([
            universityPictureView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            universityPictureView.centerYAnchor.constraint(equalTo: centerYAnchor),
            universityPictureView.widthAnchor.constraint(equalToConstant: 50),
            universityPictureView.heightAnchor.constraint(equalToConstant: 50),
            
            activityLoading.centerXAnchor.constraint(equalTo: universityPictureView.centerXAnchor),
            activityLoading.centerYAnchor.constraint(equalTo: universityPictureView.centerYAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: universityPictureView.trailingAnchor, constant: 15),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            countryLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            countryLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            countryLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            countryLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -9)
        ])
    }
    
    func configure(with viewModel: UniversityCellViewModel) {
        nameLabel.text = viewModel.name
        countryLabel.text = viewModel.country
        universityPictureView.image = nil
        activityLoading.startAnimating()
        
        if let imageURL = viewModel.imageURL {
            loadPicture(from: imageURL) { [weak self] image in
                self?.activityLoading.stopAnimating()
                self?.universityPictureView.image = image
            }
        } else {
            activityLoading.stopAnimating()
        }
    }
    
    // Картинку для университетов загружаем
    private func loadPicture(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let data = data, let image = UIImage(data: data) {
                    completion(image)
                } else {
                    completion(nil)
                }
            }
        }.resume()
    }
}
