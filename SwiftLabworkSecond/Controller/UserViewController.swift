import UIKit


// Добавила, чтобы отрисовывались странички университетов, при нажатии на них,
// На сервис ссылку фото университета и его описание добавила
class UserViewController: UIViewController {
    private let config: ScreenConfig
    private let mapper: BDUIMapperProtocol
    private let networkService: NetworkServiceProtocol
    
    private let containerView = UIView()
    private var errorLabel: UILabel?
    private var retryButton: UIButton?
    
    init(config: ScreenConfig, mapper: BDUIMapperProtocol, networkService: NetworkServiceProtocol) {
        self.config = config
        self.mapper = mapper
        self.networkService = networkService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        if let title = config.title {
            self.title = title
        }
        
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func loadData() {
        let urlString = config.endpoint.replacingOccurrences(of: ":key", with: config.key)
        networkService.fetchData(from: urlString) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    if let jsonString = String(data: data, encoding: .utf8) {
                        print("Received JSON: \(jsonString)")
                    } else {
                        print("Failed to decode!")
                    }
                    self?.handleData(data)
                case .failure(let error):
                    self?.showError()
                }
            }
        }
    }
    
    private func handleData(_ data: Data) {
        do {
            let model = try JSONDecoder().decode(BDUIViewModel.self, from: data)
            let view = mapper.map(from: model)
    
            
            self.errorLabel?.removeFromSuperview()
            self.retryButton?.removeFromSuperview()
            containerView.subviews.forEach { $0.removeFromSuperview() }
            containerView.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                view.topAnchor.constraint(equalTo: containerView.topAnchor),
                view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
            ])
        } catch {
            showError()
        }
    }
    
    //Если нет университета на сервисе, то будет предложение посмотреть про Итмо)
    private func showError() {
        errorLabel?.removeFromSuperview()
        retryButton?.removeFromSuperview()
        
        errorLabel = UILabel()
        errorLabel?.text = "Now no info about this university, very sorry about it! But you can read about ITMO:"
        errorLabel?.textColor = .red
        errorLabel?.textAlignment = .center
        errorLabel?.numberOfLines = 0
        errorLabel?.font = .systemFont(ofSize: 16)
        containerView.addSubview(errorLabel!)
        errorLabel?.translatesAutoresizingMaskIntoConstraints = false
        
        let linkLabel = UILabel()
        let itmoLink = "https://abit.itmo.ru/bachelor?utm_source=yandex_search&utm_medium=cpc&utm_campaign=118356380&utm_content=16864052882&utm_term=---autotargeting&calltouch_tm=yd_c%3A118356380_gb%3A5544482087_ad%3A16864052882_ph%3A54355177186_st%3Asearch_pt%3Apremium_p%3A2_s%3Anone_dt%3Adesktop_reg%3A2_ret%3A54355177186_apt%3Anone&yclid=8528120185782796287"
        linkLabel.text = "Visit ITMO"
        linkLabel.textColor = .blue
        linkLabel.textAlignment = .center
        linkLabel.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openLink))
        linkLabel.addGestureRecognizer(tapGesture)
        containerView.addSubview(linkLabel)
        linkLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            errorLabel!.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            errorLabel!.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: -40),
            errorLabel!.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            errorLabel!.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            linkLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            linkLabel.topAnchor.constraint(equalTo: errorLabel!.bottomAnchor, constant: 8),
            linkLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            linkLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
    
        ])
    }
    
    @objc private func openLink() {
        let toItmoSite = "https://abit.itmo.ru/bachelor?utm_source=yandex_search&utm_medium=cpc&utm_campaign=118356380&utm_content=16864052882&utm_term=---autotargeting&calltouch_tm=yd_c%3A118356380_gb%3A5544482087_ad%3A16864052882_ph%3A54355177186_st%3Asearch_pt%3Apremium_p%3A2_s%3Anone_dt%3Adesktop_reg%3A2_ret%3A54355177186_apt%3Anone&yclid=8528120185782796287"
        if let url = URL(string: toItmoSite) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @objc private func retryLoading() {
        errorLabel?.removeFromSuperview()
        retryButton?.removeFromSuperview()
        loadData()
    }
}
