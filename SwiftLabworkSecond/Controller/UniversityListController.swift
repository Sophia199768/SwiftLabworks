import UIKit

class UniversityListController: UIViewController, TableManagerDelegate {
    private let viewModel: UniversityViewModel
    private let router: Router
    private var tableManager: TableManager
    private let tableView = UITableView()
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    private let refreshControl = UIRefreshControl()
    
    private var mainStackView: StackView!
    private var titleLabel: Label!
    
    init(viewModel: UniversityViewModel, router: Router, tableManager: TableManager = UniversityTableManager()) {
        self.viewModel = viewModel
        self.router = router
        self.tableManager = tableManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        tableManager.setup(with: tableView)
        tableManager.delegate = self
        viewModel.loadUniversities()
    }
    
    private func setupUI() {
        view.backgroundColor = Color.background

        titleLabel = Label(viewModel: LabelViewModel(
            style: .head,
            text: "List of Universities",
            isHidden: false
        ))
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.refreshControl = refreshControl
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to Refresh")
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(titleLabel)
        view.addSubview(tableView)
        view.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Space.s),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Space.s),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Space.s),
    
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Space.m),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Space.s),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Space.s),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Space.s),

            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc private func refreshData() {
        viewModel.resetAndLoadUniversities()
    }
    
    private func bindViewModel() {
        viewModel.onUniversitiesUpdated = { [weak self] in
            guard let self = self else { return }
            let cellViewModels = self.viewModel.cellViewModels
            self.tableManager.update(with: cellViewModels)
            self.refreshControl.endRefreshing()
        }
        
        viewModel.onLoadingStateChanged = { [weak self] isLoading in
            isLoading ? self?.activityIndicator.startAnimating() : self?.activityIndicator.stopAnimating()
        }
        
        viewModel.onError = { [weak self] errorMessage in
            self?.refreshControl.endRefreshing()
            let errorLabel = Label(viewModel: LabelViewModel(
                style: .error,
                text: errorMessage,
                isHidden: false
            ))
            self?.router.showAlert(
                title: "Error",
                message: errorMessage,
                from: self!
            )
        }
    }
    
    func didSelectItem(at index: Int) {
        guard let university = viewModel.university(at: index) else { return }
        

        let key = university.name.replacingOccurrences(of: " ", with: "_")
        let config = ScreenConfig(
            endpoint: "https://alfa-itmo.ru/server/v1/storage/:key",
            key: key,
            title: university.name
        )
        
        let mapper = BDUIMapper()
        let networkService = NetworkService()
        let universalVC = UniversalViewController(config: config, mapper: mapper, networkService: networkService)
        
        navigationController?.pushViewController(universalVC, animated: true)
    }
}
