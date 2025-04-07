import UIKit

class UniversityListController: UIViewController, TableManagerDelegate {
    private let viewModel: UniversityViewModel
    private let router: Router
    private let tableManager: TableManager
    private let tableView = UITableView()
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    private let refreshControl = UIRefreshControl()
    
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
        (tableManager as? UniversityTableManager)?.delegate = self
        viewModel.loadUniversities()
    }
    
    private func setupUI() {
        title = "List of Universities"
        // Цвет заднего фона будет небесно голубым
        view.backgroundColor = UIColor(
            red: 135/255.0,
            green: 206/255.0,
            blue: 235/255.0,
            alpha: 0.9
        )
        
        // UIRefreshControl и обновлять контент по Pull-to-Refresh
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to Refresh")
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
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
            //Loading
            isLoading ? self?.activityIndicator.startAnimating() : self?.activityIndicator.stopAnimating()
        }
        
        viewModel.onError = { [weak self] errorMessage in
            self?.refreshControl.endRefreshing()
            let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self?.present(alert, animated: true)
        }
    }
    
    func didSelectItem(at index: Int) {
        print("\(index)")
    }
}
